

coloc_ndnaroi<-function(image_directory,
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
  
  
  ###


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
  df$CaseID=sapply(strsplit( df$CaseID, ' '), '[', 1)
  df$replicate=sapply(strsplit( rownames(df), ' '), '[', 2)
  df$replicate=sub('\\/.*', '', df$replicate)
  df$replicate=sub('\\..*', '', df$replicate)
  df$replicate=paste0(df$CaseID, ' ',df$replicate)
  df=df[which(df$CaseID %in% metadata$CaseID),]
  

  if(any(grepl("package:plyr", search()))) detach("package:plyr") else message("plyr not loaded")
  
  # Filter count outliers 
  df$Slice=as.factor(df$Slice)
  df$Total.Area=as.numeric(df$Total.Area)
  quantiles=df %>% 
    group_by(Slice)%>%
    summarize(sdx0=-outliers_threshold*sd(Total.Area, na.rm=TRUE)+mean(Total.Area, na.rm=TRUE),
              sdx1=outliers_threshold*sd(Total.Area, na.rm=TRUE)+mean(Total.Area, na.rm=TRUE))
  
  `%!in%` <- Negate(`%in%`)
  markers=c(reference_marker,marker1,marker2,marker3,marker4,marker5) 
  df_filtered=df[df$Slice %in% markers,]
  flags=df_filtered %>% left_join(quantiles, by = 'Slice') %>% 
    filter(Total.Area > sdx1| Total.Area < sdx0)
  
  
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
    dplyr::summarize(Mean_count = mean(Count, na.rm = TRUE), Mean_area=mean(Total.Area, na.rm = TRUE), Mean_size=mean(Average.Size, na.rm = TRUE)) %>% 
    as.data.frame()
  
  
  ## merge metadata
  metadata=metadata[which(metadata$CaseID %in% results$CaseID),]
  merge=merge(results,metadata,all=TRUE, by='CaseID')
  
  
  
  if(number_marker==1){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
    
    
    colnames(summary)=c('CaseID',paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)')) 
    
    
    summary2=merge(summary,metadata, by='CaseID')
    summary2[[outcome]]=factor(as.character(summary2[[outcome]]))
    
    plot_list=list()
    for(marker in colnames(summary2)[2:((number_marker*3)+2)]){
      y_pos=c(max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[1])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[2])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[3])], na.rm=T))
      
      y_pos=max(y_pos)
      y_pos=c((y_pos+2),(y_pos+6),(y_pos+12))
      
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05, y_position=y_pos)+
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
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker2area = Mean_area[Slice==paste0(marker2)],
                marker2refarea = Mean_area[Slice==paste0(marker2,reference_marker)],
                marker2ref= 100*(Mean_area[Slice==paste0(marker2,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
                
    
    colnames(summary)=c('CaseID',paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=merge(summary,metadata, by='CaseID')
    summary2[[outcome]]=factor(as.character(summary2[[outcome]]))
    
    
    plot_list=list()
    for(marker in colnames(summary2)[2:((number_marker*3)+2)]){
      y_pos=c(max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[1])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[2])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[3])], na.rm=T))
      
      y_pos=max(y_pos)
      y_pos=c((y_pos+2),(y_pos+6),(y_pos+12))
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05, y_position=y_pos)+
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
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker2area = Mean_area[Slice==paste0(marker2)],
                marker2refarea = Mean_area[Slice==paste0(marker2,reference_marker)],
                marker2ref= 100*(Mean_area[Slice==paste0(marker2,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker3area = Mean_area[Slice==paste0(marker3)],
                marker3refarea = Mean_area[Slice==paste0(marker3,reference_marker)],
                marker3ref = 100*(Mean_area[Slice==paste0(marker3,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
    
    
    
    colnames(summary)=c('CaseID',paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker3,' Area (Sq Micrometers)'),paste0(marker3,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=merge(summary,metadata, by='CaseID')
    summary2[[outcome]]=factor(as.character(summary2[[outcome]]))
    
    plot_list=list()
    for(marker in colnames(summary2)[2:((number_marker*3)+2)]){
      y_pos=c(max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[1])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[2])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[3])], na.rm=T))
      
      y_pos=max(y_pos)
      y_pos=c((y_pos+2),(y_pos+6),(y_pos+12))
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05, y_position=y_pos)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                       axis.title=element_text(size=12,face="plain")) +   xlab(" ")+ggtitle(paste0(marker))
      
      
    }
    
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
  }
  
  
  
  if(number_marker==4){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker2area = Mean_area[Slice==paste0(marker2)],
                marker2refarea = Mean_area[Slice==paste0(marker2,reference_marker)],
                marker2ref= 100*(Mean_area[Slice==paste0(marker2,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker3area = Mean_area[Slice==paste0(marker3)],
                marker3refarea = Mean_area[Slice==paste0(marker3,reference_marker)],
                marker3ref = 100*(Mean_area[Slice==paste0(marker3,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker4area = Mean_area[Slice==paste0(marker4)],
                marker4refarea = Mean_area[Slice==paste0(marker4,reference_marker)],
                marker4ref = 100*(Mean_area[Slice==paste0(marker4,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
    
    
    
    colnames(summary)=c('CaseID',paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker3,' Area (Sq Micrometers)'),paste0(marker3,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker4,' Area (Sq Micrometers)'),paste0(marker4,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=merge(summary,metadata, by='CaseID')
    summary2[[outcome]]=factor(as.character(summary2[[outcome]]))
    
    
    plot_list=list()
    for(marker in colnames(summary2)[2:((number_marker*3)+2)]){
      y_pos=c(max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[1])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[2])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[3])], na.rm=T))
      
      y_pos=max(y_pos)
      y_pos=c((y_pos+2),(y_pos+6),(y_pos+12))
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05, y_position=y_pos)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                       axis.title=element_text(size=12,face="plain")) +   xlab(" ")+ggtitle(paste0(marker))
      
      
    }
    
    pdf(file=paste0(results_directory,"/colocalisation.pdf"))
    print(plot_list)
    dev.off()
    
    
  }
  if(number_marker==5){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker2area = Mean_area[Slice==paste0(marker2)],
                marker2refarea = Mean_area[Slice==paste0(marker2,reference_marker)],
                marker2ref= 100*(Mean_area[Slice==paste0(marker2,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker3area = Mean_area[Slice==paste0(marker3)],
                marker3refarea = Mean_area[Slice==paste0(marker3,reference_marker)],
                marker3ref = 100*(Mean_area[Slice==paste0(marker3,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker4area = Mean_area[Slice==paste0(marker4)],
                marker4refarea = Mean_area[Slice==paste0(marker4,reference_marker)],
                marker4ref = 100*(Mean_area[Slice==paste0(marker4,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker5area = Mean_area[Slice==paste0(marker5)],
                marker5refarea = Mean_area[Slice==paste0(marker5,reference_marker)],
                marker5ref = 100*(Mean_area[Slice==paste0(marker5,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
                
    
    
    colnames(summary)=c('CaseID',paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker3,' Area (Sq Micrometers)'),paste0(marker3,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker4,' Area (Sq Micrometers)'),paste0(marker4,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker5,' Area (Sq Micrometers)'),paste0(marker5,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker5,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=merge(summary,metadata, by='CaseID')
    summary2[[outcome]]=factor(as.character(summary2[[outcome]]))
    
    plot_list=list()
    for(marker in colnames(summary2)[2:((number_marker*3)+2)]){
      y_pos=c(max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[1])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[2])], na.rm=T),
              max(summary2[[paste0(marker)]][which(summary2[[paste(outcome)]]==levels(summary2[[paste(outcome)]])[3])], na.rm=T))
      
      y_pos=max(y_pos)
      y_pos=c((y_pos+2),(y_pos+6),(y_pos+12))
      
      plot_list[[marker]]<-ggboxplot(summary2, x=paste(outcome), y=paste0(marker),fill=paste(outcome),
                                     add = "jitter", size=1)+
        geom_signif(comparisons = split(t(combn(levels(summary2[[outcome]]), 2)), seq(nrow(t(combn(levels(summary2[[outcome]]), 2))))), 
                    map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, "ns"=2), tip_length = .05, y_position=y_pos)+
        ylab(paste(marker))+ggsci::scale_fill_npg(name='Groups')+theme(axis.text=element_text(size=16),
                                                                       axis.title=element_text(size=12,face="plain")) +   xlab(" ")+ggtitle(paste0(marker))
      
      
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
    nSamples = (length(unique(df$replicate))-nFlags)
  }else{
    nSamples = length(unique(df$replicate))
  }
  
  
  rmarkdown::render(paste0(CoMarker_directory,"/HTML Reports/report_ndnaroi.Rmd"),
                    output_dir =paste0(results_directory,'/Report'),
                    output_file='CoMarker_Analysis_Report',
                    quiet = T)
  
  }

