coloc_wrapper=function(image_directory="/Users/samboulger/Desktop/Manual Counts",
                       results_directory="/Users/samboulger/Desktop/Manual Counts",
                       metadata,
                       number_marker=2,
                       reference_marker="Iba1",
                       marker1="CD68",
                       marker2='HLA-DR',
                       marker3='',
                       marker4='',
                       marker5='',
                       region_of_interest='Ab',
                       outcome='trem2_all',
                       DNA=TRUE,
                       ROI=TRUE){
  
  
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
  
  
  
  source("coloc_nroi.R")
  source("coloc_ndnaroi.R")
  source("coloc_ndna.R")
  source("coloc.R")
  
  if(DNA==TRUE & ROI==FALSE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata=metadata,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome)
    do.call(coloc_nroi,arg)  
  }
  
  if(DNA==FALSE & ROI==TRUE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata=metadata,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome)
    do.call(coloc_ndna,arg) 
  }
  
  if(DNA==FALSE & ROI==FALSE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata=metadata,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome)
    do.call(coloc_ndnaroi,arg) 
  }
  
  if(DNA==TRUE & ROI==TRUE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata=metadata,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome)
    do.call(coloc,arg)
    
  }
  
}