coloc<-function(image_directory,
                metadata_directory,
                results_directory,
                CoMarker_directory,
                number_marker,
                reference_marker,
                marker1,
                marker2,
                marker3,
                marker4,
                marker5,
                region_of_interest,
                outcome,
                remove_outliers,
                outliers_threshold) {
  
  
  
  #####
  
  sigFunc = function(x){
    if(x < 0.001){"***"} 
    else if(x < 0.01){"**"}
    else if(x < 0.05){"*"}
    else{NA}}
  
  
library(dplyr)
  
  metadata=read_csv(paste0(metadata_directory,'metadata.csv'))
  metadata=metadata %>%  mutate(across(where(is_character),as_factor))

  setwd(image_directory)
  
  
  if(number_marker==1){
    files=list.files(pattern = "onemarker.csv$", recursive = TRUE)
  }
  
  if(number_marker==2){
    files=list.files(pattern = "twomarkers.csv$", recursive = TRUE)
  }
  if(number_marker==3){
    files=list.files(pattern = "threemarkers.csv$", recursive = TRUE)
  }
  if(number_marker==4){
    files=list.files(pattern = "fourmarkers.csv$", recursive = TRUE)
  }
  if(number_marker==5){
    files=list.files(pattern = "fivemarkers.csv$", recursive = TRUE)
  }
  
  
  my.data <- list()
  for (i in 1:length(files)){
    my.data[[i]] <- read.csv(files[[i]])
  }
  
  
  names(my.data)=substr(files,1,12)
  df <- do.call("rbind", my.data)
  
  ## reorganise colnames
  df$CaseID=rownames(df)
  df$CaseID=sub("\\i.*", "", df$CaseID)
  df$CaseID=gsub(" ","",df$CaseID)
  
  rep=c('i','ii','iii','iv','v','vi')
  
  replicate=sapply(rownames(df), function(x){
    rep[str_detect(x,rep)]
  })
  
  replicate_list=lapply(replicate, function(x){
    x[[length(x)]]
  })
  rep_df=do.call(rbind,  replicate_list)
  df$replicate=paste0(df$CaseID, ' ',rep_df[,1])

  if(any(grepl("package:plyr", search()))) detach("package:plyr") else message("plyr not loaded")
  # Filter count outliers 
  df$Slice=as.factor(df$Slice)
  df$Count=as.numeric(df$Count)
  quantiles=df %>% 
  group_by(Slice)%>%
  summarize(sdx0=-outliers_threshold*sd(Count, na.rm=TRUE)+mean(Count, na.rm=TRUE),
            sdx1=outliers_threshold*sd(Count, na.rm=TRUE)+mean(Count, na.rm=TRUE))
  
  `%!in%` <- Negate(`%in%`)
  markers=c(reference_marker,marker1,marker2,marker3,marker4,marker5, region_of_interest,"nucleus") 
  df_filtered=df[df$Slice %in% markers,]
  flags=df_filtered %>% left_join(quantiles, by = 'Slice') %>% 
    filter(Count > sdx1| Count < sdx0)

  
  replicated_flags=flags$replicate


  if(remove_outliers==TRUE){
    df=df[which(df$replicate %!in% replicated_flags),]
  }
  
  
  if (sum(unique(metadata$CaseID) %in% unique(df$CaseID))!=length(unique(df$CaseID))){
    stop('The case IDs in the image directory must match the case IDs in the metadata.')
  }
  
  ### get average of replicates
  results=df %>%
    group_by(CaseID,Slice)%>%
    dplyr::summarize(Mean_count = mean(Count, na.rm = TRUE), Mean_area=mean(Total.Area, na.rm = TRUE)) %>% 
    as.data.frame()
  
  
  ## merge metadata
  metadata=metadata[which(metadata$CaseID %in% results$CaseID),]
  merge=merge(results,metadata,all=TRUE, by='CaseID')
  

  library(plyr)
  
  if(number_marker==1){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(ROIcount = Mean_count[Slice==paste0(region_of_interest)],
                ROIarea = Mean_area[Slice==paste0(region_of_interest)],
                refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                refcountROI = Mean_count[Slice==paste0(reference_marker,' Cell ROI')],
                refcountnoROI = (Mean_count[Slice==paste0(reference_marker,' Cell')])-(Mean_count[Slice==paste0(reference_marker,' Cell ROI')]),
                refROI = 100*(Mean_count[Slice==paste0(reference_marker,' Cell ROI')] / Mean_count[Slice==paste0(reference_marker,' Cell')]),
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1countROI = Mean_count[Slice==paste0(marker1,' Cell ROI')],
                marker1countnoROI = (Mean_count[Slice==paste0(marker1,' Cell')])-(Mean_count[Slice==paste0(marker1,' Cell ROI')]),
                marker1ROI = 100*(Mean_count[Slice==paste0(marker1,' Cell ROI')] / Mean_count[Slice==paste0(marker1,' Cell')]),
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1refcountROI = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')],
                marker1refcountnoROI = (Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')]),
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker1refROI = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)]))
    
    colnames(summary)=c(paste0(region_of_interest,' Count'),paste0(region_of_interest,' Area (Sq Micrometers)'),paste0(reference_marker,' Cell Count'),paste0(reference_marker,' Cell Count ROI'),
                        paste0(reference_marker,' Cell Count Outside of ROI'),paste0(reference_marker,' ROI (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' Cell Count'),paste0(marker1,' Cell Count ROI'),paste0(marker1,' Cell Count Outside of ROI'),paste0(marker1,' ROI (% of Total ',marker1,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),paste0(marker1,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation ROI (% of Total ',marker1,' ',reference_marker,' Colocalised Cell Count)')) 

    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
      
      plot_list=list()
      for(marker in colnames(summary2)[1:((number_marker*9)+6)]){
        
        plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                       add = "jitter", size=1)+
          geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                      map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05)+
          ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                         axis.title=element_text(size=12,face="plain")) +   xlab(" ")+ggtitle(paste0(marker))
        
        
      }
    
    
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
  }
  
  ### TWO MARKERS
  if(number_marker==2){

    
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(ROIcount = Mean_count[Slice==paste0(region_of_interest)],
                ROIarea = Mean_area[Slice==paste0(region_of_interest)],
                refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                refcountROI = Mean_count[Slice==paste0(reference_marker,' Cell ROI')],
                refcountnoROI = (Mean_count[Slice==paste0(reference_marker,' Cell')])-(Mean_count[Slice==paste0(reference_marker,' Cell ROI')]),
                refROI = 100*(Mean_count[Slice==paste0(reference_marker,' Cell ROI')] / Mean_count[Slice==paste0(reference_marker,' Cell')]),
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1countROI = Mean_count[Slice==paste0(marker1,' Cell ROI')],
                marker1countnoROI = (Mean_count[Slice==paste0(marker1,' Cell')])-(Mean_count[Slice==paste0(marker1,' Cell ROI')]),
                marker1ROI = 100*(Mean_count[Slice==paste0(marker1,' Cell ROI')] / Mean_count[Slice==paste0(marker1,' Cell')]),
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1refcountROI = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')],
                marker1refcountnoROI = (Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')]),
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker1refROI = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2countROI = Mean_count[Slice==paste0(marker2,' Cell ROI')],
                marker2countnoROI = (Mean_count[Slice==paste0(marker2,' Cell')])-(Mean_count[Slice==paste0(marker2,' Cell ROI')]),
                marker2ROI = 100*(Mean_count[Slice==paste0(marker2,' Cell ROI')] / Mean_count[Slice==paste0(marker2,' Cell')]),
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2refcountROI = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')],
                marker2refcountnoROI = (Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')]),
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2refROI = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)]))
    
    
    colnames(summary)=c(paste0(region_of_interest,' Count'),paste0(region_of_interest,' Area (Sq Micrometers)'),paste0(reference_marker,' Cell Count'),paste0(reference_marker,' Cell Count ROI'),
                        paste0(reference_marker,' Cell Count Outside of ROI'),paste0(reference_marker,' ROI (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' Cell Count'),paste0(marker1,' Cell Count ROI'),paste0(marker1,' Cell Count Outside of ROI'),paste0(marker1,' ROI (% of Total ',marker1,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),paste0(marker1,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation ROI (% of Total ',marker1,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker2,' Cell Count'), paste0(marker2,' Cell Count ROI'),paste0(marker2,' Cell Count Outside of ROI'),paste0(marker2,' ROI (% of Total ',marker2,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation ROI (% of Total ',marker2,' ',reference_marker,' Colocalised Cell Count)'))
    

    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*9)+6)]){
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                                                        axis.title=element_text(size=12,face="plain")) +   xlab(" ")+ggtitle(paste0(marker))
      
      
    }
    
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
  }
  
  
  if(number_marker==3){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(ROIcount = Mean_count[Slice==paste0(region_of_interest)],
                ROIarea = Mean_area[Slice==paste0(region_of_interest)],
                refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                refcountROI = Mean_count[Slice==paste0(reference_marker,' Cell ROI')],
                refcountnoROI = (Mean_count[Slice==paste0(reference_marker,' Cell')])-(Mean_count[Slice==paste0(reference_marker,' Cell ROI')]),
                refROI = 100*(Mean_count[Slice==paste0(reference_marker,' Cell ROI')] / Mean_count[Slice==paste0(reference_marker,' Cell')]),
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1countROI = Mean_count[Slice==paste0(marker1,' Cell ROI')],
                marker1countnoROI = (Mean_count[Slice==paste0(marker1,' Cell')])-(Mean_count[Slice==paste0(marker1,' Cell ROI')]),
                marker1ROI = 100*(Mean_count[Slice==paste0(marker1,' Cell ROI')] / Mean_count[Slice==paste0(marker1,' Cell')]),
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1refcountROI = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')],
                marker1refcountnoROI = (Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')]),
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker1refROI = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2countROI = Mean_count[Slice==paste0(marker2,' Cell ROI')],
                marker2countnoROI = (Mean_count[Slice==paste0(marker2,' Cell')])-(Mean_count[Slice==paste0(marker2,' Cell ROI')]),
                marker2ROI = 100*(Mean_count[Slice==paste0(marker2,' Cell ROI')] / Mean_count[Slice==paste0(marker2,' Cell')]),
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2refcountROI = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')],
                marker2refcountnoROI = (Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')]),
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2refROI = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)]),
                marker3count = Mean_count[Slice==paste0(marker3,' Cell')],
                marker3countROI = Mean_count[Slice==paste0(marker3,' Cell ROI')],
                marker3countnoROI = (Mean_count[Slice==paste0(marker3,' Cell')])-(Mean_count[Slice==paste0(marker3,' Cell ROI')]),
                marker3ROI = 100*(Mean_count[Slice==paste0(marker3,' Cell ROI')] / Mean_count[Slice==paste0(marker3,' Cell')]),
                marker3refcount = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)],
                marker3refcountROI = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')],
                marker3refcountnoROI = (Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')]),
                marker3ref = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker3refROI = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)]))
    
    colnames(summary)=c(paste0(region_of_interest,' Count'),paste0(region_of_interest,' Area (Sq Micrometers)'),paste0(reference_marker,' Cell Count'),paste0(reference_marker,' Cell Count ROI'),
                        paste0(reference_marker,' Cell Count Outside of ROI'),paste0(reference_marker,' ROI (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' Cell Count'),paste0(marker1,' Cell Count ROI'),paste0(marker1,' Cell Count Outside of ROI'),paste0(marker1,' ROI (% of Total ',marker1,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),paste0(marker1,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation ROI (% of Total ',marker1,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker2,' Cell Count'), paste0(marker2,' Cell Count ROI'),paste0(marker2,' Cell Count Outside of ROI'),paste0(marker2,' ROI (% of Total ',marker2,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation ROI (% of Total ',marker2,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker3,' Cell Count'),paste0(marker3,' Cell Count ROI'),paste0(marker3,' Cell Count Outside of ROI'),paste0(marker3,' ROI (% of Total ',marker3,' Cell Count)'),
                        paste0(marker3,' ',reference_marker,' Colocalised Cell Count'),paste0(marker3,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker3,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation ROI (% of Total ',marker3,' ',reference_marker,' Colocalised Cell Count)'))
    

    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*9)+6)]){
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                       axis.title=element_text(size=12,face="plain")) +   xlab(" ")++ggtitle(paste0(marker))
      
      
    }
    
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
  }
  
  
  
  if(number_marker==4){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(ROIcount = Mean_count[Slice==paste0(region_of_interest)],
                ROIarea = Mean_area[Slice==paste0(region_of_interest)],
                refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                refcountROI = Mean_count[Slice==paste0(reference_marker,' Cell ROI')],
                refcountnoROI = (Mean_count[Slice==paste0(reference_marker,' Cell')])-(Mean_count[Slice==paste0(reference_marker,' Cell ROI')]),
                refROI = 100*(Mean_count[Slice==paste0(reference_marker,' Cell ROI')] / Mean_count[Slice==paste0(reference_marker,' Cell')]),
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1countROI = Mean_count[Slice==paste0(marker1,' Cell ROI')],
                marker1countnoROI = (Mean_count[Slice==paste0(marker1,' Cell')])-(Mean_count[Slice==paste0(marker1,' Cell ROI')]),
                marker1ROI = 100*(Mean_count[Slice==paste0(marker1,' Cell ROI')] / Mean_count[Slice==paste0(marker1,' Cell')]),
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1refcountROI = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')],
                marker1refcountnoROI = (Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')]),
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker1refROI = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2countROI = Mean_count[Slice==paste0(marker2,' Cell ROI')],
                marker2countnoROI = (Mean_count[Slice==paste0(marker2,' Cell')])-(Mean_count[Slice==paste0(marker2,' Cell ROI')]),
                marker2ROI = 100*(Mean_count[Slice==paste0(marker2,' Cell ROI')] / Mean_count[Slice==paste0(marker2,' Cell')]),
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2refcountROI = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')],
                marker2refcountnoROI = (Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')]),
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2refROI = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)]),
                marker3count = Mean_count[Slice==paste0(marker3,' Cell')],
                marker3countROI = Mean_count[Slice==paste0(marker3,' Cell ROI')],
                marker3countnoROI = (Mean_count[Slice==paste0(marker3,' Cell')])-(Mean_count[Slice==paste0(marker3,' Cell ROI')]),
                marker3ROI = 100*(Mean_count[Slice==paste0(marker3,' Cell ROI')] / Mean_count[Slice==paste0(marker3,' Cell')]),
                marker3refcount = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)],
                marker3refcountROI = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')],
                marker3refcountnoROI = (Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')]),
                marker3ref = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker3refROI = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)]),
                marker4count = Mean_count[Slice==paste0(marker4,' Cell')],
                marker4countROI = Mean_count[Slice==paste0(marker4,' Cell ROI')],
                marker4countnoROI = (Mean_count[Slice==paste0(marker4,' Cell')])-(Mean_count[Slice==paste0(marker4,' Cell ROI')]),
                marker4ROI = 100*(Mean_count[Slice==paste0(marker4,' Cell ROI')] / Mean_count[Slice==paste0(marker4,' Cell')]),
                marker4refcount = Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)],
                marker4refcountROI = Mean_count[Slice==paste0(marker4," colocalised ",reference_marker,' ROI')],
                marker4refcountnoROI = (Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker,' ROI')]),
                marker4ref = 100*(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker4refROI = 100*(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)]))
                
    colnames(summary)=c(paste0(region_of_interest,' Count'),paste0(region_of_interest,' Area (Sq Micrometers)'),paste0(reference_marker,' Cell Count'),paste0(reference_marker,' Cell Count ROI'),
                        paste0(reference_marker,' Cell Count Outside of ROI'),paste0(reference_marker,' ROI (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' Cell Count'),paste0(marker1,' Cell Count ROI'),paste0(marker1,' Cell Count Outside of ROI'),paste0(marker1,' ROI (% of Total ',marker1,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),paste0(marker1,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation ROI (% of Total ',marker1,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker2,' Cell Count'), paste0(marker2,' Cell Count ROI'),paste0(marker2,' Cell Count Outside of ROI'),paste0(marker2,' ROI (% of Total ',marker2,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation ROI (% of Total ',marker2,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker3,' Cell Count'),paste0(marker3,' Cell Count ROI'),paste0(marker3,' Cell Count Outside of ROI'),paste0(marker3,' ROI (% of Total ',marker3,' Cell Count)'),
                        paste0(marker3,' ',reference_marker,' Colocalised Cell Count'),paste0(marker3,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker3,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation ROI (% of Total ',marker3,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker4,' Cell Count'),paste0(marker4,' Cell Count ROI'),paste0(marker4,' Cell Count Outside of ROI'),paste0(marker4,' ROI (% of Total ',marker4,' Cell Count)'),
                        paste0(marker4,' ',reference_marker,' Colocalised Cell Count'),paste0(marker4,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker4,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker4,' ',reference_marker,' Colocalisation ROI (% of Total ',marker4,' ',reference_marker,' Colocalised Cell Count)'))
   

    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*9)+6)]){
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                       axis.title=element_text(size=12,face="plain")) +   xlab(" ")++ggtitle(paste0(marker))
      
      
    }
    
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
    
  }
  if(number_marker==5){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(ROIcount = Mean_count[Slice==paste0(region_of_interest)],
                ROIarea = Mean_area[Slice==paste0(region_of_interest)],
                refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                refcountROI = Mean_count[Slice==paste0(reference_marker,' Cell ROI')],
                refcountnoROI = (Mean_count[Slice==paste0(reference_marker,' Cell')])-(Mean_count[Slice==paste0(reference_marker,' Cell ROI')]),
                refROI = 100*(Mean_count[Slice==paste0(reference_marker,' Cell ROI')] / Mean_count[Slice==paste0(reference_marker,' Cell')]),
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1countROI = Mean_count[Slice==paste0(marker1,' Cell ROI')],
                marker1countnoROI = (Mean_count[Slice==paste0(marker1,' Cell')])-(Mean_count[Slice==paste0(marker1,' Cell ROI')]),
                marker1ROI = 100*(Mean_count[Slice==paste0(marker1,' Cell ROI')] / Mean_count[Slice==paste0(marker1,' Cell')]),
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1refcountROI = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')],
                marker1refcountnoROI = (Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')]),
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker1refROI = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2countROI = Mean_count[Slice==paste0(marker2,' Cell ROI')],
                marker2countnoROI = (Mean_count[Slice==paste0(marker2,' Cell')])-(Mean_count[Slice==paste0(marker2,' Cell ROI')]),
                marker2ROI = 100*(Mean_count[Slice==paste0(marker2,' Cell ROI')] / Mean_count[Slice==paste0(marker2,' Cell')]),
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2refcountROI = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')],
                marker2refcountnoROI = (Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')]),
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2refROI = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)]),
                marker3count = Mean_count[Slice==paste0(marker3,' Cell')],
                marker3countROI = Mean_count[Slice==paste0(marker3,' Cell ROI')],
                marker3countnoROI = (Mean_count[Slice==paste0(marker3,' Cell')])-(Mean_count[Slice==paste0(marker3,' Cell ROI')]),
                marker3ROI = 100*(Mean_count[Slice==paste0(marker3,' Cell ROI')] / Mean_count[Slice==paste0(marker3,' Cell')]),
                marker3refcount = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)],
                marker3refcountROI = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')],
                marker3refcountnoROI = (Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')]),
                marker3ref = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker3refROI = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)]),
                marker4count = Mean_count[Slice==paste0(marker4,' Cell')],
                marker4countROI = Mean_count[Slice==paste0(marker4,' Cell ROI')],
                marker4countnoROI = (Mean_count[Slice==paste0(marker4,' Cell')])-(Mean_count[Slice==paste0(marker4,' Cell ROI')]),
                marker4ROI = 100*(Mean_count[Slice==paste0(marker4,' Cell ROI')] / Mean_count[Slice==paste0(marker4,' Cell')]),
                marker4refcount = Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)],
                marker4refcountROI = Mean_count[Slice==paste0(marker4," colocalised ",reference_marker,' ROI')],
                marker4refcountnoROI = (Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker,' ROI')]),
                marker4ref = 100*(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker4refROI = 100*(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)]),
                marker5count = Mean_count[Slice==paste0(marker5,' Cell')],
                marker5countROI = Mean_count[Slice==paste0(marker5,' Cell ROI')],
                marker5countnoROI = (Mean_count[Slice==paste0(marker5,' Cell')])-(Mean_count[Slice==paste0(marker5,' Cell ROI')]),
                marker5ROI = 100*(Mean_count[Slice==paste0(marker5,' Cell ROI')] / Mean_count[Slice==paste0(marker5,' Cell')]),
                marker5refcount = Mean_count[Slice==paste0(marker5," colocalised ",reference_marker)],
                marker5refcountROI = Mean_count[Slice==paste0(marker5," colocalised ",reference_marker,' ROI')],
                marker5refcountnoROI = (Mean_count[Slice==paste0(marker5," colocalised ",reference_marker)])-(Mean_count[Slice==paste0(marker5," colocalised ",reference_marker,' ROI')]),
                marker5ref = 100*(Mean_count[Slice==paste0(marker5," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker5refROI = 100*(Mean_count[Slice==paste0(marker5," colocalised ",reference_marker,' ROI')] / Mean_count[Slice==paste0(marker5," colocalised ",reference_marker)]))
    
    colnames(summary)=c(paste0(region_of_interest,' Count'),paste0(region_of_interest,' Area (Sq Micrometers)'),paste0(reference_marker,' Cell Count'),paste0(reference_marker,' Cell Count ROI'),
                        paste0(reference_marker,' Cell Count Outside of ROI'),paste0(reference_marker,' ROI (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' Cell Count'),paste0(marker1,' Cell Count ROI'),paste0(marker1,' Cell Count Outside of ROI'),paste0(marker1,' ROI (% of Total ',marker1,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),paste0(marker1,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation ROI (% of Total ',marker1,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker2,' Cell Count'), paste0(marker2,' Cell Count ROI'),paste0(marker2,' Cell Count Outside of ROI'),paste0(marker2,' ROI (% of Total ',marker2,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker2,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation ROI (% of Total ',marker2,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker3,' Cell Count'),paste0(marker3,' Cell Count ROI'),paste0(marker3,' Cell Count Outside of ROI'),paste0(marker3,' ROI (% of Total ',marker3,' Cell Count)'),
                        paste0(marker3,' ',reference_marker,' Colocalised Cell Count'),paste0(marker3,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker3,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation ROI (% of Total ',marker3,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker4,' Cell Count'),paste0(marker4,' Cell Count ROI'),paste0(marker4,' Cell Count Outside of ROI'),paste0(marker4,' ROI (% of Total ',marker4,' Cell Count)'),
                        paste0(marker4,' ',reference_marker,' Colocalised Cell Count'),paste0(marker4,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker4,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker4,' ',reference_marker,' Colocalisation ROI (% of Total ',marker4,' ',reference_marker,' Colocalised Cell Count)'),
                        paste0(marker5,' Cell Count'),paste0(marker5,' Cell Count ROI'),paste0(marker5,' Cell Count Outside of ROI'),paste0(marker5,' ROI (% of Total ',marker5,' Cell Count)'),
                        paste0(marker5,' ',reference_marker,' Colocalised Cell Count'),paste0(marker5,' ',reference_marker,' Colocalised Cell Count ROI'),
                        paste0(marker5,' ',reference_marker,' Colocalised Cell Count Outside of ROI'),paste0(marker5,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker5,' ',reference_marker,' Colocalisation ROI (% of Total ',marker5,' ',reference_marker,' Colocalised Cell Count)'))

    
    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*9)+6)]){
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                       axis.title=element_text(size=12,face="plain")) +   xlab(" ")++ggtitle(paste0(marker))
      
      
    }
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
  }

setwd(results_directory)
dir.create('Report')
dir.create('Files')
list_param=list(image_directory=image_directory,
          results_directory=results_directory,
          CoMarker_directory=CoMarker_directory,
          metadata,
          number_marker=number_marker,
          reference_marker=reference_marker,
          marker1=marker1,
          marker2=marker2,
          marker3=marker3,
          marker4=marker4,
          marker5=marker5,
          region_of_interest=region_of_interest,
          outcome=outcome)
saveRDS(list_param,paste0(results_directory,'/Files/list_param.rds'))
saveRDS(metadata,paste0(results_directory,'/Files/metadata.rds'))
saveRDS(plot_list,paste0(results_directory,'/Files/plot_list.rds'))


plot_data = list()
for (name in names(plot_list)){
  plot_data[[name]] = ggplot_build(plot_list[[name]])}


signif=list()
for(name in names(plot_list)){
  signif[[paste(name)]]=plot_data[[name]][["data"]][[3]][["annotation"]]
}

sig_count = sum(unlist(lapply(signif,function(x){x!=c('ns')})))/3
nCases = length(unique(results$CaseID))

nFlags = length(unique(replicated_flags))

if(remove_outliers==TRUE){
  nSamples = (length(my.data)-nFlags)
}else{
nSamples = length(my.data)
}


rmarkdown::render(paste0(CoMarker_directory,"/HTML Reports/report.Rmd"),
                  output_dir =paste0(results_directory,'/Report'),
                  output_file='CoMarker_Analysis_Report',
                  quiet = T)

}

