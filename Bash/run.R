
args <- commandArgs(trailingOnly = TRUE)

image_directory=args[1]
results_directory=args[2]
metadata_directory=args[3]
CoMarker_directory=args[4]
DNA=args[5]
ROI=args[6]
number_marker=as.numeric(args[7])
reference_marker=args[8]
marker1=args[9]
marker2=args[10]
marker3=args[11]
marker4=args[12]
marker5=args[13]
region_of_interest=args[14]
outcome=args[15]
remove_outliers=args[16]

print(CoMarker_directory)


source(paste0(CoMarker_directory,"Functions/wrapper.R"))
coloc_wrapper(image_directory=image_directory,
                       results_directory=results_directory,
                       metadata_directory=metadata_directory,
                       CoMarker_directory=CoMarker_directory,
                       DNA=DNA,
                       ROI=ROI,
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