# CoMarker - Marker Colocalisation Analysis

This document contains a brief overview of CoMarker and a set of confined instructions. Please see our website for more information.

## Preface

This manual introduces an image analysis package, CoMarker, which was built to vastly decrease the time taken to assess the colocalisation of markers, whilst eliminating subjectivity. Our script takes a cell-based approach, utilising nuclei markers to count cells which are positive for any given marker(s) and analyse the colocalisation of said markers, both respective and irrespective of a defined region of interest. We have, however, developed functions which allow users without a nuclei marker to revert to area coverage as the method of analysis.

The package is written in ImageJ Macro language (IJM) and R, but doesn't require previous knowledge of either language. The purpose of this code is to save time, money and resources by fully automating the analysis of markers, hence the script is capable of producing a report with a range of box plots with annotated statistical significance from an input of raw images in a short period of time.

### The Purpose of CoMarker

CoMarker was designed to imitate manual counts by taking a cell-based approach to marker analysis. Existing marker colocalisation analysis packages use a pixel-based approach to assess the area covered by any marker - therefore colocalisation is described as the number of pixels covered by two or more markers.

We allow the use of this pixel based-approach for users without a nuclei marker, however it is recommended that a nuclei marker is used in order to make the most out of the package. When using the cell-based approach, colocalisation is described as any cell containing both the defined reference marker and any other included marker. Consequently, the produced results are a better representation of the expression of cellular markers when the required output is the identification of cells positive for markers.

The example images that we use in this website were produced by imaging mass cytometry - an immunohistochemistry technology that provides an integrative spatial tissue analysis. CoMarker has the capacity to analyse images produced by any staining method as long as the images for each marker are separated and not merged.

### Acknowledgements

CoMarker was developed by Samuel Boulger, Eleonore Schneegans, and Vicky Chau at UK Dementia Research Institute, Imperial College London.


## Brief Instructions

This section describes how to use the script from start to finish, without too much extra detail.

### Download the Script

1. Download the github repo and save the folder on your device.

2. The main folder must include the 'Functions' and 'HTML Reports' folders. This naming is crucial for the R script to run.

### Run ImageJ

3. Download Fiji ImageJ here if it is not already installed on your device.

4. Open the script named 'CoMarker_Macro.ijm' on ImageJ, and click run.

5. Input your parameters in the dialog box, referring to the ImageJ Walkthrough section of this site for additional details.

6. Once all three parameter boxes have been completed, the script will run automatically. The time taken to run the script will depend on the number of images used. It typically takes 1 to 8 seconds to analyse all of the images for each case.

7. Once the script has finished running, ImageJ may be closed.

### Run R Studio

8. Open the R script and input the parameters, as explained in the R Walkthrough section of this site.

9. Ensure that 'CoMarker_directory' is set to the directory of the main folder on your device, as shown by the example input parameters.

10. Run the script. A HTML document will be produced in the results directory, summarising your results.

