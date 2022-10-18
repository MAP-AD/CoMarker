source('Functions/wrapper.R')

coloc_wrapper(image_directory="~/Desktop/IMC_Biogen/MTG/",
              results_directory="~/Desktop/res_MTG/",
              metadata_directory="~/Desktop/mtg_meta/",
              CoMarker_directory="~/Desktop/CoMarker/",
              DNA=TRUE,
              ROI=FALSE,
              number_marker=1,
              reference_marker="MAP2",
              marker1="pTau",
              marker2='',
              marker3='',
              marker4='',
              marker5='',
              region_of_interest="",
              outcome="trem2_all",
              remove_outliers=TRUE,
              outliers_threshold=2)



