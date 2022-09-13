source('Functions/wrapper.R')

coloc_wrapper(image_directory="/Users/samboulger/Desktop/CoMarker/SampleDirectory/Images/",
              results_directory="/Users/samboulger/Desktop/CoMarker/SampleDirectory/",
              metadata_directory='/Users/samboulger/Desktop/CoMarker/SampleDirectory/Metadata/',
              CoMarker_directory='/Users/samboulger/Desktop/CoMarker/',
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



