library(tidyverse)
library(plyr)
library(readr)
library(stringr)
library(dplyr)
library(rqdatatable)
library(rlist)
library(ggplot2)
library(gridExtra)
library(ggsignif)
library(ggpubr)
library(paletteer)




palette_choice <- paletteer::paletteer_d("ggsci::nrc_npg")


metadata=read_csv('metadata.csv')
metadata$trem2_all=ifelse(metadata$TREM2Variant=='none','CV','TREM2')

metadata$CaseID=str_replace(metadata$CaseID, pattern='/', replacement='.')
metadata$CaseID=str_replace(metadata$CaseID, pattern='-', replacement='.')
metadata$CaseID=str_replace(metadata$CaseID, pattern=fixed('*'), replacement= '')
metadata=metadata[c("CaseID","AD/CTRL","TREM2Variant",'APOE','PostMortemDelayHours','trem2_all')]
metadata=metadata[!duplicated(metadata$CaseID),]
metadata$PostMortemDelayHours=as.numeric(metadata$PostMortemDelayHours)
metadata$pmi_median=ifelse(metadata$PostMortemDelayHours>median(metadata$PostMortemDelayHours, na.rm = TRUE),'High_pmi','Low_pmi')
metadata$pmi_median=as.factor(metadata$pmi_median)

colocalisation_analysis(image_directory="/Users/samboulger/Desktop/GLUT1 HistoCAT/AD",
                        results_directory="/Users/samboulger/Desktop/GLUT1 HistoCAT/AD",
                        metadata,
                        number_marker=2,
                        reference_marker="Fibrinogen",
                        marker1="Ab",
                        marker2='CD163',
                        marker3='',
                        marker4='',
                        marker5='',
                        outcome='APOE')

colocalisation_analysis<-function(image_directory="/Users/samboulger/Desktop/Manual Counts",
                                  results_directory="/Users/samboulger/Desktop/Manual Counts",
                                  metadata,
                                  number_marker=2,
                                  reference_marker="Iba1",
                                  marker1="CD68",
                                  marker2='HLA-DR',
                                  marker3='',
                                  marker4='',
                                  marker5='',
                                  outcome='trem2_all') {
  
  
  
  #####
  
  sigFunc = function(x){
    if(x < 0.001){"***"} 
    else if(x < 0.01){"**"}
    else if(x < 0.05){"*"}
    else{NA}}
  
  
  ###
  
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
  df$replicate=sub("\\/.*", "", rownames(df))
  df$replicate=sub("\\..*", "", df$replicate)
  
  
  ### get average of replicates
  results=df %>%
    group_by(CaseID,Slice)%>%
    dplyr::summarize(Mean_count = mean(Count), Mean_area=mean(Total.Area)) %>% 
    as.data.frame()
  
  
  ## merge metadata
  metadata=metadata[which(metadata$CaseID %in% results$CaseID),]
  merge=merge(results,metadata,all=TRUE, by='CaseID')
  
  #denominator
  
  if(number_marker==1){
    ## summarise
    summary=merge %>%
      group_by(CaseID) %>%
      summarise(refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]))
    
    
    colnames(summary)=c(paste0(reference_marker,' Cell Count'),paste0(marker1,' Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)')) 
    
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
      summarise(refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]))
    
    
    colnames(summary)=c(paste0(reference_marker,' Cell Count'),paste0(marker1,' Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'))
    
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
      summarise(refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker3count = Mean_count[Slice==paste0(marker3,' Cell')],
                marker3refcount = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)],
                marker3ref = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]))
    
    
    colnames(summary)=c(paste0(reference_marker,' Cell Count'),paste0(marker1,' Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker3,' Cell Count'),paste0(marker3,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'))
    
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
      summarise(refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker3count = Mean_count[Slice==paste0(marker3,' Cell')],
                marker3refcount = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)],
                marker3ref = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker4count = Mean_count[Slice==paste0(marker4,' Cell')],
                marker4refcount = Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)],
                marker4ref = 100*(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]))
    
    
    colnames(summary)=c(paste0(reference_marker,' Cell Count'),paste0(marker1,' Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker2,' Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker3,' Cell Count'),paste0(marker3,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                        paste0(marker4,' Cell Count'),paste0(marker4,' ',reference_marker,' Colocalised Cell Count'),
                        paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'))
    
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
      summarise(refcount = Mean_count[Slice==paste0(reference_marker,' Cell')],
                marker1count = Mean_count[Slice==paste0(marker1,' Cell')],
                marker1refcount = Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)],
                marker1ref = 100*(Mean_count[Slice==paste0(marker1," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker2count = Mean_count[Slice==paste0(marker2,' Cell')],
                marker2refcount = Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)],
                marker2ref = 100*(Mean_count[Slice==paste0(marker2," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker3count = Mean_count[Slice==paste0(marker3,' Cell')],
                marker3refcount = Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)],
                marker3ref = 100*(Mean_count[Slice==paste0(marker3," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker4count = Mean_count[Slice==paste0(marker4,' Cell')],
                marker4refcount = Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)],
                marker4ref = 100*(Mean_count[Slice==paste0(marker4," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]),
                marker5count = Mean_count[Slice==paste0(marker5,' Cell')],
                marker5refcount = Mean_count[Slice==paste0(marker5," colocalised ",reference_marker)],
                marker5ref = 100*(Mean_count[Slice==paste0(marker5," colocalised ",reference_marker)] / Mean_count[Slice==paste0(reference_marker," Cell")]))
                
                
                colnames(summary)=c(paste0(reference_marker,' Cell Count'),paste0(marker1,' Cell Count'),
                                    paste0(marker1,' ',reference_marker,' Colocalised Cell Count'),
                                    paste0(marker1,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                                    paste0(marker2,' Cell Count'),paste0(marker2,' ',reference_marker,' Colocalised Cell Count'),
                                    paste0(marker2,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                                    paste0(marker3,' Cell Count'),paste0(marker3,' ',reference_marker,' Colocalised Cell Count'),
                                    paste0(marker3,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                                    paste0(marker4,' Cell Count'),paste0(marker4,' ',reference_marker,' Colocalised Cell Count'),
                                    paste0(marker4,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'),
                                    paste0(marker5,' Cell Count'),paste0(marker5,' ',reference_marker,' Colocalised Cell Count'),
                                    paste0(marker5,' ',reference_marker,' Colocalisation (% of Total ',reference_marker,' Cell Count)'))
    
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
  saveRDS(list_param,paste0(dir,'/results/list_param.rds'))
  saveRDS(metadata,paste0(dir,'/results/metadata.rds'))
  saveRDS(plot_list,paste0(dir,'/results/plot_list.rds'))
  
}

