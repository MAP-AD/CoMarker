source('Functions/wrapper.R')

coloc_wrapper(image_directory="/Users/eleonoreschneegans/Documents/CoMarker/SampleDirectory/Images/",
              results_directory="/Users/eleonoreschneegans/Documents/CoMarker/SampleDirectory/",
              metadata_directory='/Users/eleonoreschneegans/Documents/CoMarker/SampleDirectory/Metadata/',
              CoMarker_directory='/Users/eleonoreschneegans/Documents/CoMarker/',
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
              outliers_threshold=3.5)

