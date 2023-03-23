coloc_wrapper=function(image_directory,
                       metadata_directory,
                       results_directory,
                       CoMarker_directory,
                       DNA=TRUE,
                       ROI=TRUE,
                       number_marker=2,
                       reference_marker="Iba1",
                       marker1="CD68",
                       marker2='HLA-DR',
                       marker3='',
                       marker4='',
                       marker5='',
                       region_of_interest='Ab',
                       outcome='AD/CTRL',
                       remove_outliers=TRUE,
                       outliers_threshold=4){
  
  
  library(tidyverse)
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
  op <- options(ggpubr.parse_aes = FALSE)

  
  source(paste0(CoMarker_directory,"Functions/coloc_nroi.R"))
  source(paste0(CoMarker_directory,"Functions/coloc_ndnaroi.R"))
  source(paste0(CoMarker_directory,"Functions/coloc_ndna.R"))
  source(paste0(CoMarker_directory,"Functions/coloc.R"))
  
  if(DNA==TRUE && ROI==FALSE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata_directory=metadata_directory,
             CoMarker_directory=CoMarker_directory,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome,
             remove_outliers=remove_outliers,
             outliers_threshold=outliers_threshold)
    do.call(coloc_nroi,arg)  
  }
  
  if(DNA==FALSE && ROI==TRUE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata_directory=metadata_directory,
             CoMarker_directory=CoMarker_directory,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome,
             remove_outliers=remove_outliers,
             outliers_threshold=outliers_threshold)
    do.call(coloc_ndna,arg) 
  }
  
  if(DNA==FALSE && ROI==FALSE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata_directory=metadata_directory,
             CoMarker_directory=CoMarker_directory,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome,
             remove_outliers=remove_outliers,
             outliers_threshold=outliers_threshold)
    do.call(coloc_ndnaroi,arg) 
  }
  
  if(DNA==TRUE && ROI==TRUE){
    arg=list(image_directory=image_directory,
             results_directory=results_directory,
             metadata_directory=metadata_directory,
             CoMarker_directory=CoMarker_directory,
             number_marker=number_marker,
             reference_marker=reference_marker,
             marker1=marker1,
             marker2=marker2,
             marker3=marker3,
             marker4=marker4,
             marker5=marker5,
             region_of_interest=region_of_interest,
             outcome=outcome,
             remove_outliers=remove_outliers,
             outliers_threshold=outliers_threshold)
    do.call(coloc,arg)
    
  }
  
}

