source('Functions/wrapper.R')

coloc_wrapper(image_directory="~/Desktop/images/",
              results_directory="~/Desktop/results/",
              metadata_directory="~/Desktop/metadata/",
              CoMarker_directory="~/Desktop/CoMarker/",
              DNA=TRUE,
              ROI=TRUE,
              number_marker=1,
              reference_marker="Iba1",
              marker1="CD68",
              marker2='',
              marker3='',
              marker4='',
              marker5='',
              region_of_interest="Ab",
              outcome="AD/CTRL",
              remove_outliers=TRUE,
              outliers_threshold=2)



