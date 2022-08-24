

coloc_ndnaroi<-function(image_directory,
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
                                     outcome) {
  
  
  #####
  
  sigFunc = function(x){
    if(x < 0.001){"***"} 
    else if(x < 0.01){"**"}
    else if(x < 0.05){"*"}
    else{NA}}
  
  
  ###
  
  setwd(image_directory)
  metadata=read_csv('metadata.csv')
  metadata=metadata %>% mutate_if(is.character,factor)
  
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
  df$replicate=sub("\\/.*", "", rownames(df))
  df$replicate=sub("\\..*", "", df$replicate)
  
  if (sum(unique(metadata$CaseID) %in% unique(df$CaseID))!=length(unique(df$CaseID))){
    stop('The case IDs in the image directory must match the case IDs in the metadata.')
  }
  
  ### get average of replicates
  results=df %>%
    group_by(CaseID,Slice)%>%
    dplyr::summarize(Mean_count = mean(Count), Mean_area=mean(Total.Area), Mean_size=mean(Average.Size)) %>% 
    as.data.frame()
  
  
  ## merge metadata
  metadata=metadata[which(metadata$CaseID %in% results$CaseID),]
  merge=merge(results,metadata,all=TRUE, by='CaseID')
  
  #denominator
  
  if(number_marker==1){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
    
    
    colnames(summary)=c(paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)')) 
    
    
    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*3)+1)]){
      
      
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
      summarise(refarea = Mean_area[Slice==paste0(reference_marker)],
                marker1area = Mean_area[Slice==paste0(marker1)],
                marker1refarea = Mean_area[Slice==paste0(marker1,reference_marker)],
                marker1ref = 100*(Mean_area[Slice==paste0(marker1,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]),
                marker2area = Mean_area[Slice==paste0(marker2)],
                marker2refarea = Mean_area[Slice==paste0(marker2,reference_marker)],
                marker2ref= 100*(Mean_area[Slice==paste0(marker2,reference_marker)] / Mean_area[Slice==paste0(reference_marker)]))
                
    
    colnames(summary)=c(paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*3)+1)]){
      
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
    
    
    
    colnames(summary)=c(paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker3,' Area (Sq Micrometers)'),paste0(marker3,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*3)+1)]){
      
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
    
    
    
    colnames(summary)=c(paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker2,' Area (Sq Micrometers)'),paste0(marker2,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker3,' Area (Sq Micrometers)'),paste0(marker3,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'),
                        paste0(marker4,' Area (Sq Micrometers)'),paste0(marker4,' ',reference_marker, ' Colocalised Area (Sq Micrometers)'),
                        paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Area)'))

    
    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*3)+1)]){
      
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
                
    
    
    colnames(summary)=c(paste0(reference_marker,' Area (Sq Micrometers)'),paste0(marker1,' Area (Sq Micrometers)'),
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

    
    summary2=cbind(summary,metadata)
    summary2[[outcome]]=as.factor(summary2[[outcome]])
    
    plot_list=list()
    for(marker in colnames(summary2)[1:((number_marker*3)+1)]){
      
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
  dir=getwd()
  dir.create('results')
  list_param=list(image_directory=image_directory,
                  results_directory=results_directory,
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
  saveRDS(list_param,paste0(results_directory,'/results/list_param.rds'))
  saveRDS(metadata,paste0(results_directory,'/results/metadata.rds'))
  saveRDS(plot_list,paste0(results_directory,'/results/plot_list.rds'))
  
  plot_data = list()
  for (name in names(plot_list)){
    plot_data[[name]] = ggplot_build(plot_list[[name]])}
  
  
  signif=list()
  for(name in names(plot_list)){
    signif[[paste(name)]]=plot_data[[name]][["data"]][[3]][["annotation"]]
  }
  
  sig_count = sum(unlist(lapply(signif,function(x){x!=c('ns')})))/3
  nCases = nrow(metadata)
  nSamples = length(my.data)
  
  rmarkdown::render(paste0(CoMarker_directory,"/HTML Reports/report_ndnaroi.Rmd"),
                    output_dir =paste0(results_directory,'/results'),
                    output_file='CoMarker_Analysis_Report',
                    quiet = T)
  
  }

