
args <- commandArgs(trailingOnly = TRUE)

image_directory=args[1]
results_directory=args[2]
CoMarker_directory=args[3]
DNA=args[4]
ROI=args[5]
number_marker=as.numeric(args[6])
reference_marker=args[7]
marker1=args[8]
marker2=args[9]
marker3=args[10]
marker4=args[11]
marker5=args[12]
region_of_interest=args[13]
outcome=args[14]
remove_outliers=args[15]

print(CoMarker_directory)


source(paste0(CoMarker_directory,"Functions/wrapper.R"))
coloc_wrapper(image_directory=image_directory,
                       results_directory=results_directory,
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
                       outcome=outcome)