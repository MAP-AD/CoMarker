yesno=newArray("Yes","No");
thresholds=newArray("Default","Huang","Intermodes","IsoData","Li","MaxEntropy","Mean","MinError","Minimum","Moments","Otsu","Percentile","RenyiEntropy","Shanbhag","Triangle","Yen");
roi_gaus="Yes"
roi_area=1;
roi_thresh="Otsu";
radius=0;
// specify user parameters
Dialog.create("Colocalisation analysis options (1/3)");
	Dialog.addMessage("Enter your settings here:");
	Dialog.addString("Reference marker", "Iba1");
	Dialog.addString("Reference marker minimum area (pixels)", 6);
	Dialog.addChoice("Reference marker autothresholding method",thresholds,"Otsu");
	Dialog.addChoice("Has DNA marker",yesno,"Yes");
	Dialog.addChoice("Has region of interest",yesno,"Yes");
	Dialog.addNumber("Number of markers to colocalise",2);
	Dialog.show();
	
reference_marker=Dialog.getString();
ref_area=Dialog.getString();
ref_thresh=Dialog.getChoice();
has_DNA=Dialog.getChoice();
has_roi=Dialog.getChoice();
number_markers=Dialog.getNumber();

Dialog.create("Colocalisation analysis options (2/3)");
if (has_DNA=="Yes"){
	Dialog.addString("DNA minimum area (pixels)", 4);
	Dialog.addChoice("DNA autothresholding method",thresholds,"Otsu");
	}
	Dialog.addNumber("Marker colocalisation radius (pixels)", 2);
	if(has_roi=="Yes"){
	Dialog.addString("Region of interest", "Ab");
	Dialog.addChoice("Use Gaussian and Watershed on ROI",yesno,"Yes");
	Dialog.addString("Region of interest minimum area (pixels)", 1100);
	Dialog.addChoice("ROI Marker autothresholding method",thresholds,"Otsu");
	Dialog.addNumber("Radius around region of interest (pixels)", 10);
	}
	Dialog.show();
if (has_DNA=="Yes"){	
DNA_area=Dialog.getString();
DNA_thresh=Dialog.getChoice();
}
coloc_radius=Dialog.getNumber();
if (has_roi=="Yes"){
region_of_interest=Dialog.getString();
roi_gaus=Dialog.getChoice();
roi_area=Dialog.getString();
roi_thresh=Dialog.getChoice();
radius=Dialog.getNumber();
}
Dialog.create("Colocalisation analysis options (3/3)");
if (number_markers==1){
	Dialog.addString("Name of 1st marker", "Ab");
	Dialog.addString("1st marker minimum area (pixels)", 8);
	Dialog.addChoice("Marker 1 autothresholding method",thresholds,"Otsu");
	Dialog.show();
marker1=Dialog.getString();
m1_area=Dialog.getString();
m1_thresh=Dialog.getChoice();
}else if (number_markers==2){
	Dialog.addString("Name of 1st marker", "p16");
	Dialog.addString("1st marker minimum area (pixels)", 4);
	Dialog.addChoice("Marker 1 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 2nd marker", "GLB1");
	Dialog.addString("2nd marker minimum area (pixels)", 4);
	Dialog.addChoice("Marker 2 autothresholding method",thresholds,"Otsu");
	Dialog.show();
marker1=Dialog.getString();
m1_area=Dialog.getString();
m1_thresh=Dialog.getChoice();
marker2=Dialog.getString();
m2_area=Dialog.getString();
m2_thresh=Dialog.getChoice();
}else if (number_markers==3){
	Dialog.addString("Name of 1st marker", "Ab");
	Dialog.addString("1st marker minimum area (pixels)", 8);
	Dialog.addChoice("Marker 1 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 2nd marker", "CD163");
	Dialog.addString("2nd marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 2 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 3rd marker", "NA");
	Dialog.addString("3rd marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 3 autothresholding method",thresholds,"Otsu");
	Dialog.show();
marker1=Dialog.getString();
m1_area=Dialog.getString();
m1_thresh=Dialog.getChoice();
marker2=Dialog.getString();
m2_area=Dialog.getString();
m2_thresh=Dialog.getChoice();
marker3=Dialog.getString();
m3_area=Dialog.getString();
m3_thresh=Dialog.getChoice();
}else if (number_markers==4){
	Dialog.addString("Name of 1st marker", "Ab");
	Dialog.addString("1st marker minimum area (pixels)", 8);
	Dialog.addChoice("Marker 1 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 2nd marker", "CD163");
	Dialog.addString("2nd marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 2 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 3rd marker", "NA");
	Dialog.addString("3rd marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 3 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 4th marker", "NA");
	Dialog.addString("4th marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 4 autothresholding method",thresholds,"Otsu");
	Dialog.show();
marker1=Dialog.getString();
m1_area=Dialog.getString();
m1_thresh=Dialog.getChoice();
marker2=Dialog.getString();
m2_area=Dialog.getString();
m2_thresh=Dialog.getChoice();
marker3=Dialog.getString();
m3_area=Dialog.getString();
m3_thresh=Dialog.getChoice();
marker4=Dialog.getString();
m4_area=Dialog.getString();
m4_thresh=Dialog.getChoice();
}else if (number_markers==5){
	Dialog.addString("Name of 1st marker", "Ab");
	Dialog.addString("1st marker minimum area (pixels)", 8);
	Dialog.addChoice("Marker 1 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 2nd marker", "CD163");
	Dialog.addString("2nd marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 2 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 3rd marker", "NA");
	Dialog.addString("3rd marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 3 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 4th marker", "NA");
	Dialog.addString("4th marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 4 autothresholding method",thresholds,"Otsu");
	Dialog.addString("Name of 5th marker", "NA");
	Dialog.addString("5th marker minimum area (pixels)", 2);
	Dialog.addChoice("Marker 5 autothresholding method",thresholds,"Otsu");
Dialog.show();
marker1=Dialog.getString();
m1_area=Dialog.getString();
m1_thresh=Dialog.getChoice();
marker2=Dialog.getString();
m2_area=Dialog.getString();
m2_thresh=Dialog.getChoice();
marker3=Dialog.getString();
m3_area=Dialog.getString();
m3_thresh=Dialog.getChoice();
marker4=Dialog.getString();
m4_area=Dialog.getString();
m4_thresh=Dialog.getChoice();
marker5=Dialog.getString();
m5_area=Dialog.getString();
m5_thresh=Dialog.getChoice();
}



SourceDir = getDirectory('~/');

print(SourceDir);
print(reference_marker);
print(ref_area);
print(ref_thresh);
print(has_DNA);
print(has_roi);
print(number_markers);
print(DNA_area);
print(DNA_thresh);
print(coloc_radius);
print(region_of_interest);
print(roi_gaus);
print(roi_area);
print(roi_thresh);
print(radius);

list = getFileList(SourceDir);

if(number_markers==1){

// Takes a directory containing sub-directories, loads them in sorted order and does an operation on them
for(i = 0; i < list.length; i++) {

     subdir = SourceDir + list[i];
     if(has_DNA=="Yes"){
     One_marker(subdir);
     }else {
     One_marker_noDNA(subdir);
     }
}}


if(number_markers==2){

// Takes a directory containing sub-directories, loads them in sorted order and does an operation on them
for(i = 0; i < list.length; i++) {

     subdir = SourceDir + list[i];
     if(has_DNA=="Yes"){
     Two_markers(subdir);
     }else {
     Two_markers_noDNA(subdir);
     }
}}

if(number_markers==3){

// Takes a directory containing sub-directories, loads them in sorted order and does an operation on them
for(i = 0; i < list.length; i++) {

     subdir = SourceDir + list[i];
     if(has_DNA=="Yes"){
     Three_markers(subdir);
     }else {
     Three_markers_noDNA(subdir);
     }
}}

if(number_markers==4){

// Takes a directory containing sub-directories, loads them in sorted order and does an operation on them
for(i = 0; i < list.length; i++) {

     subdir = SourceDir + list[i];
     if(has_DNA=="Yes"){
     Four_markers(subdir);
     }else {
     Four_markers_noDNA(subdir);
     }
}}

if(number_markers==5){

// Takes a directory containing sub-directories, loads them in sorted order and does an operation on them
for(i = 0; i < list.length; i++) {

     subdir = SourceDir + list[i];
     if(has_DNA=="Yes"){
     Five_markers(subdir);
     }else {
     Five_markers_noDNA(subdir);
     }
}}



//////////////////////////////////////////////////1MARKER///////////////////////////////////////////////

function One_marker(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Reference marker has DNA marker to identify nucleus?
open(subdir+"DNA.tif");

if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}
// Coloc marker 1
open(subdir+marker1+".tif");



run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
//if ROI present
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


selectWindow("DNA.tif"); /// Should always have DNA name 
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(DNA_thresh+" dark");
run("Convert to Mask");
run("Watershed");
selectWindow("DNA.tif");

run("Analyze Particles...", "size=DNA_area-Infinity pixel show=Masks summarize"); //check image with a lot of cells, might see two nuclei count as one, or one nucleus split into fragments 
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , "nucleus");
	
selectWindow("Mask of DNA.tif");
run("Create Selection");
//if there are DNA
if (selectionType() != -1){
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "DNA");

roiManager("Select", 2);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "DNA_enlarged");

roiManager("Select", newArray(1,2)); //finding nucleus within given radius of ROI 
roiManager("AND");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_region_intersect"); // DNA in plaque region
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "yellow");
roiManager("Set Line Width", 2);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_RoI_enlarged");

//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 2, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");

//if reference marker present
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+reference_marker);
RoiManager.setPosition(0);
roiManager("Select", count-1);

roiManager("Select", newArray(2,7)); //Enalrged reference signal DNA
roiManager("AND");
//if there is reference signal around DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);
selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker + " Cell");
rename(reference_marker+" Cells");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");

roiManager("Select", newArray(4,8)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//if there is reference marker around the region of interest 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

selectWindow("Mask of DNA.tif");
count = roiManager("count");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" Cell ROI");
rename(reference_marker+" Cell ROI");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker1);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker1 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" Cell ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER 1 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker+ " ROI");
  }
//if no marker1 positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker1 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+" Cell");
	Table.set("Slice", n+1 , marker1+" Cell ROI");
	Table.set("Slice", n+2, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+3,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" Cell");
	Table.set("Slice", n+2 , marker1+" Cell ROI");
	Table.set("Slice", n+3, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+4,  marker1+" colocalised "+reference_marker+ " ROI");
	}

//no reference marker in region of interest 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" Cell");
	Table.set("Slice", n+3, marker1+" Cell ROI");
	Table.set("Slice", n+4, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<6; i++){
			Table.set("Count", i, "NA");
		}
	}

}//no reference marker near DNA
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell");
	Table.set("Slice", n+1, reference_marker+" Cell ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" Cell");
	Table.set("Slice", n+4, marker1+" Cell ROI");
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker+ " ROI");
	for (i=2; i<7; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no reference marker in the image
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" Cell");
	Table.set("Slice", n+2, reference_marker+" Cell ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" Cell");
	Table.set("Slice", n+5, marker1+" Cell ROI");
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker+ " ROI");
	for (i=3; i<8; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no DNA
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, "nucleus");
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" Cell");
	Table.set("Slice", n+3, reference_marker+" Cell ROI");
	Table.set("Slice", n+4, marker1);
	Table.set("Slice", n+5, marker1+" Cell");
	Table.set("Slice", n+6, marker1+" Cell ROI");
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+8, marker1+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<9; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no region of interest in the image
else {
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest);
	Table.set("Slice", 1, "nucleus");
	Table.set("Slice", 2, reference_marker);
	Table.set("Slice", 3, reference_marker+" Cell");
	Table.set("Slice", 4, reference_marker+" Cell ROI");
	Table.set("Slice", 5, marker1);
	Table.set("Slice", 6, marker1+" Cell");
	Table.set("Slice", 7, marker1+" Cell ROI");
	Table.set("Slice", 8, marker1+" colocalised "+reference_marker);
	Table.set("Slice", 9, marker1+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<10; i++){
			Table.set("Count", i, "NA");
		}
	}


IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "onemarker.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}

////////////////////////////////////////////////2MARKERS//////////////////////////////////////////////


function Two_markers(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Reference marker has DNA marker ot identify nucleus?
open(subdir+"DNA.tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else {
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");


run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");

if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");

run("Create Selection");
//if ROI present
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


selectWindow("DNA.tif"); /// Should always have DNA name 
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(DNA_thresh+" dark");
run("Convert to Mask");
run("Watershed");
selectWindow("DNA.tif");

run("Analyze Particles...", "size=DNA_area-Infinity pixel show=Masks summarize"); //check image with a lot of cells, might see two nuclei count as one, or one nucleus split into fragments 
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , "nucleus");
	
selectWindow("Mask of DNA.tif");
run("Create Selection");
//if there are cells
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "DNA");

roiManager("Select", 2);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "DNA_enlarged");

roiManager("Select", newArray(1,2)); //finding nucleus within given radius of ROI 
roiManager("AND");

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_region_interest"); // DNA in plaque region
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "yellow");
roiManager("Set Line Width", 2);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_ROI_enlarged");

//Reference marker

selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 2, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");

//if reference marker present
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+reference_marker);
RoiManager.setPosition(0);
roiManager("Select", count-1);

roiManager("Select", newArray(2,7)); //Reference signal overlapping with enlarged DNA
roiManager("AND");
//if there is reference signal around DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);
selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker + " Cell");
rename(reference_marker+" Cells");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");

roiManager("Select", newArray(4,8)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//if there is reference marker around the region of interest 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

selectWindow("Mask of DNA.tif");
count = roiManager("count");
roiManager("Select", count-1);
if (has_roi=="Yes"){
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" Cell ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n , reference_marker+" Cell ROI");
}
rename(reference_marker+" Cell ROI");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker1);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker1 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" Cell ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER 1 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker+ " ROI");
  }
//if no marker1 positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker1 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+" Cell");
	Table.set("Slice", n+1 , marker1+" Cell ROI");
	Table.set("Slice", n+2,  marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+3,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" Cell");
	Table.set("Slice", n+2 , marker1+" Cell ROI");
	Table.set("Slice", n+3,  marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+4,  marker1+" colocalised "+reference_marker+ " ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");

//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker2);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker2 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER2 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker 2 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 2 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" Cell");
	Table.set("Slice", n+1, marker2+" Cell ROI");
	Table.set("Slice", n+2, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" Cell");
	Table.set("Slice", n+2, marker2+" Cell ROI");
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker2+" colocalised "+reference_marker+ " ROI");
	}

//no reference marker in region of interest 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" Cell");
	Table.set("Slice", n+3, marker1+" Cell ROI");
	Table.set("Slice", n+4, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" Cell");
	Table.set("Slice", n+8, marker2+" Cell ROI");
	Table.set("Slice", n+9, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<11; i++){
			Table.set("Count", i, "NA");
		}
	}

}//no reference marker near DNA
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell");
	Table.set("Slice", n+1, reference_marker+" Cell ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" Cell");
	Table.set("Slice", n+4, marker1+" Cell ROI");
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" Cell");
	Table.set("Slice", n+9, marker2+" Cell ROI");
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker+ " ROI");
	for (i=2; i<12; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no reference marker in the image
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" Cell");
	Table.set("Slice", n+2, reference_marker+" Cell ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" Cell");
	Table.set("Slice", n+5, marker1+" Cell ROI");
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+8, marker2);
	Table.set("Slice", n+9, marker2+" Cell");
	Table.set("Slice", n+10, marker2+" Cell ROI");
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker+ " ROI");
	for (i=3; i<13; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no DNA in the region of interest 
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, "nucleus");
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" Cell");
	Table.set("Slice", n+3, reference_marker+" Cell ROI");
	Table.set("Slice", n+4, marker1);
	Table.set("Slice", n+5, marker1+" Cell");
	Table.set("Slice", n+6, marker1+" Cell ROI");
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+8, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+9, marker2);
	Table.set("Slice", n+10, marker2+" Cell");
	Table.set("Slice", n+11, marker2+" Cell ROI");
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+13, marker2+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<14; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no region of interest in the image
else {
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest);
	Table.set("Slice", 1, "nucleus");
	Table.set("Slice", 2, reference_marker);
	Table.set("Slice", 3, reference_marker+" Cell");
	Table.set("Slice", 4, reference_marker+" Cell ROI");
	Table.set("Slice", 5, marker1);
	Table.set("Slice", 6, marker1+" Cell");
	Table.set("Slice", 7, marker1+" Cell ROI");
	Table.set("Slice", 8, marker1+" colocalised "+reference_marker);
	Table.set("Slice", 9, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 10, marker2);
	Table.set("Slice", 11, marker2+" Cell");
	Table.set("Slice", 12, marker2+" Cell ROI");
	Table.set("Slice", 13, marker2+" colocalised "+reference_marker);
	Table.set("Slice", 14, marker2+" colocalised "+reference_marker+ " ROI");
		for (i=1; i<15; i++){
			Table.set("Count", i, "NA");
		}

	}


IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "twomarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}


//////////////////////////////////////////////3MARKERS//////////////////////////////////////////////////


function Three_markers(subdir) {

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");	

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Reference marker has DNA marker ot identify nucleus?
open(subdir+"DNA.tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2&3
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");
open(subdir+marker3+".tif");

run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
//if plaque present
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


selectWindow("DNA.tif"); /// Should always have DNA name 
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(DNA_thresh+" dark");
run("Convert to Mask");
run("Watershed");
selectWindow("DNA.tif");

run("Analyze Particles...", "size=DNA_area-Infinity pixel show=Masks summarize"); //check image with a lot of cells, might see two nuclei count as one, or one nucleus split into fragments 
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , "nucleus");
	
selectWindow("Mask of DNA.tif");
run("Create Selection");
//if there are cells
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "DNA");

roiManager("Select", 2);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "DNA_enlarged");

roiManager("Select", newArray(1,2)); //finding nucleus within given radius of ROI 
roiManager("AND");

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_region_interest"); // DNA in plaque region
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "yellow");
roiManager("Set Line Width", 2);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_RoI_enlarged");

//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 2, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");

//if reference marker present
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+reference_marker);
RoiManager.setPosition(0);
roiManager("Select", count-1);

roiManager("Select", newArray(2,7)); //Reference signal overlapping with enlarged DNA
roiManager("AND");
//if there is reference signal around DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);
selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker + " Cell");
rename(reference_marker+" Cells");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");

roiManager("Select", newArray(4,8)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//if there is reference marker around the region of interest 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

selectWindow("Mask of DNA.tif");
count = roiManager("count");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" Cell ROI");
rename(reference_marker+" Cell ROI");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker1);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker1 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" Cell ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER 1 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker+ " ROI");
  }
//if no marker1 positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker1 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+" Cell");
	Table.set("Slice", n+1, marker1+" Cell ROI");
	Table.set("Slice", n+2, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+3,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" Cell");
	Table.set("Slice", n+2, marker1+" Cell ROI");
	Table.set("Slice", n+3, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker1+" colocalised "+reference_marker+ " ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");

//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker2);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker2 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER2 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker 2 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 2 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" Cell");
	Table.set("Slice", n+1, marker2+" Cell ROI");
	Table.set("Slice", n+2, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" Cell");
	Table.set("Slice", n+2, marker2+" Cell ROI");
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker2+" colocalised "+reference_marker+ " ROI");
	}
	
//// MARKER 3

selectWindow(marker3+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m3_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m3_area-Infinity pixel show=Masks summarize"); //get marker3 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3);
selectWindow("Mask of "+marker3+".tif");
run("Create Selection");

//if there are marker3 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker3);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker3 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker3+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK marker3 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK marker3 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK marker3 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker3 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+" colocalised "+reference_marker+ " ROI");
	}
//if no marker3 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+" Cell");
	Table.set("Slice", n+1, marker3+" Cell ROI");
	Table.set("Slice", n+2, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker3+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker3 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3);
	Table.set("Slice", n+1, marker3+" Cell");
	Table.set("Slice", n+2, marker3+" Cell ROI");
	Table.set("Slice", n+3, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker3+" colocalised "+reference_marker+ " ROI");
	}
////end marker 3

//no reference marker in region of interest 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" Cell");
	Table.set("Slice", n+3, marker1+" Cell ROI");
	Table.set("Slice", n+4, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" Cell");
	Table.set("Slice", n+8, marker2+" Cell ROI");
	Table.set("Slice", n+9, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+11, marker3);
	Table.set("Slice", n+12, marker3+" Cell");
	Table.set("Slice", n+13, marker3+" Cell ROI");
	Table.set("Slice", n+14, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+15, marker3+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<16; i++){
			Table.set("Count", i, "NA");
		}
	}

}//no reference marker near DNA
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell");
	Table.set("Slice", n+1, reference_marker+" Cell ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" Cell");
	Table.set("Slice", n+4, marker1+" Cell ROI");
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" Cell");
	Table.set("Slice", n+9, marker2+" Cell ROI");
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+12, marker3);
	Table.set("Slice", n+13, marker3+" Cell");
	Table.set("Slice", n+14, marker3+" Cell ROI");
	Table.set("Slice", n+15, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+16, marker3+" colocalised "+reference_marker+ " ROI");
	for (i=2; i<17; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no reference marker in the image
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" Cell");
	Table.set("Slice", n+2, reference_marker+" Cell ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" Cell");
	Table.set("Slice", n+5, marker1+" Cell ROI");
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+8, marker2);
	Table.set("Slice", n+9, marker2+" Cell");
	Table.set("Slice", n+10, marker2+" Cell ROI");
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+13, marker3);
	Table.set("Slice", n+14, marker3+" Cell");
	Table.set("Slice", n+15, marker3+" Cell ROI");
	Table.set("Slice", n+16, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker+ " ROI");
	for (i=3; i<18; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no DNA in the region of interest 
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, "nucleus");
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" Cell");
	Table.set("Slice", n+3, reference_marker+" Cell ROI");
	Table.set("Slice", n+4, marker1);
	Table.set("Slice", n+5, marker1+" Cell");
	Table.set("Slice", n+6, marker1+" Cell ROI");
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+8, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+9, marker2);
	Table.set("Slice", n+10, marker2+" Cell");
	Table.set("Slice", n+11, marker2+" Cell ROI");
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+13, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+14, marker3);
	Table.set("Slice", n+15, marker3+" Cell");
	Table.set("Slice", n+16, marker3+" Cell ROI");
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+18, marker3+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<19; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no region of interest in the image
else {
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest);
	Table.set("Slice", 1, "nucleus");
	Table.set("Slice", 2, reference_marker);
	Table.set("Slice", 3, reference_marker+" Cell");
	Table.set("Slice", 4, reference_marker+" Cell ROI");
	Table.set("Slice", 5, marker1);
	Table.set("Slice", 6, marker1+" Cell");
	Table.set("Slice", 7, marker1+" Cell ROI");
	Table.set("Slice", 8, marker1+" colocalised "+reference_marker);
	Table.set("Slice", 9, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 10, marker2);
	Table.set("Slice", 11, marker2+" Cell");
	Table.set("Slice", 12, marker2+" Cell ROI");
	Table.set("Slice", 13, marker2+" colocalised "+reference_marker);
	Table.set("Slice", 14, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 15, marker3);
	Table.set("Slice", 16, marker3+" Cell");
	Table.set("Slice", 17, marker3+" Cell ROI");
	Table.set("Slice", 18, marker3+" colocalised "+reference_marker);
	Table.set("Slice", 19, marker3+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<20; i++){
			Table.set("Count", i, "NA");
		}
	}


IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "threemarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}


//////////////////////////////////////////////4MARKERS//////////////////////////////////////////////////


function Four_markers(subdir) {

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
	
 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Reference marker has DNA marker ot identify nucleus?
open(subdir+"DNA.tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2&3
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");
open(subdir+marker3+".tif");
open(subdir+marker4+".tif");

run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
//if plaque present
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


selectWindow("DNA.tif"); /// Should always have DNA name 
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(DNA_thresh+" dark");
run("Convert to Mask");
run("Watershed");
selectWindow("DNA.tif");

run("Analyze Particles...", "size=DNA_area-Infinity pixel show=Masks summarize"); //check image with a lot of cells, might see two nuclei count as one, or one nucleus split into fragments 
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , "nucleus");
	
selectWindow("Mask of DNA.tif");
run("Create Selection");
//if there are cells
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "DNA");

roiManager("Select", 2);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "DNA_enlarged");

roiManager("Select", newArray(1,2)); //finding nucleus within given radius of ROI 
roiManager("AND");

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_region_interest"); // DNA in plaque region
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "yellow");
roiManager("Set Line Width", 2);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_RoI_enlarged");

//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 2, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");

//if reference marker present
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+reference_marker);
RoiManager.setPosition(0);
roiManager("Select", count-1);

roiManager("Select", newArray(2,7)); //Reference signal overlapping with enlarged DNA
roiManager("AND");
//if there is reference signal around DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);
selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker + " Cell");
rename(reference_marker+" Cells");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");

roiManager("Select", newArray(4,8)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//if there is reference marker around the region of interest 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

selectWindow("Mask of DNA.tif");
count = roiManager("count");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" Cell ROI");
rename(reference_marker+" Cell ROI");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker1);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker1 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" Cell ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER 1 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker+ " ROI");
  }
//if no marker1 positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker1 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+" Cell");
	Table.set("Slice", n+1 , marker1+" Cell ROI");
	Table.set("Slice", n+2,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" Cell");
	Table.set("Slice", n+2 , marker1+" Cell ROI");
	Table.set("Slice", n+3,  marker1+" colocalised "+reference_marker+ " ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");

//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker2);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker2 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER2 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker 2 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 2 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" Cell");
	Table.set("Slice", n+1, marker2+" Cell ROI");
	Table.set("Slice", n+2, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" Cell");
	Table.set("Slice", n+2, marker2+" Cell ROI");
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker2+" colocalised "+reference_marker+ " ROI");
	}
	
//// MARKER 3

selectWindow(marker3+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m3_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m3_area-Infinity pixel show=Masks summarize"); //get marker3 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3);
selectWindow("Mask of "+marker3+".tif");
run("Create Selection");

//if there are marker3 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker3);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker3 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker3+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK marker3 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK marker3 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK marker3 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker3 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+" colocalised "+reference_marker+ " ROI");
	}
//if no marker3 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+" Cell");
	Table.set("Slice", n+1, marker3+" Cell ROI");
	Table.set("Slice", n+2, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker3+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker3 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3);
	Table.set("Slice", n+1, marker3+" Cell");
	Table.set("Slice", n+2, marker3+" Cell ROI");
	Table.set("Slice", n+3, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker3+" colocalised "+reference_marker+ " ROI");
	}
////end marker 3

/// MARKER 4

selectWindow(marker4+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m4_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m4_area-Infinity pixel show=Masks summarize"); //get marker4 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4);
selectWindow("Mask of "+marker4+".tif");
run("Create Selection");

//if there are marker4 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker4);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker4 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker4+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK marker4 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker4 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK marker4 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker4 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK marker4 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker4 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4+" colocalised "+reference_marker+ " ROI");
	}
//if no marker4 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4+" Cell");
	Table.set("Slice", n+1, marker4+" Cell ROI");
	Table.set("Slice", n+2, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker4+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker4 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4);
	Table.set("Slice", n+1, marker4+" Cell");
	Table.set("Slice", n+2, marker4+" Cell ROI");
	Table.set("Slice", n+3, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker4+" colocalised "+reference_marker+ " ROI");
	}

////end marker 4

//no reference marker in region of interest 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" Cell");
	Table.set("Slice", n+3, marker1+" Cell ROI");
	Table.set("Slice", n+4, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" Cell");
	Table.set("Slice", n+8, marker2+" Cell ROI");
	Table.set("Slice", n+9, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+11, marker3);
	Table.set("Slice", n+12, marker3+" Cell");
	Table.set("Slice", n+13, marker3+" Cell ROI");
	Table.set("Slice", n+14, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+15, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+16, marker4);
	Table.set("Slice", n+17, marker4+" Cell");
	Table.set("Slice", n+18, marker4+" Cell ROI");
	Table.set("Slice", n+19, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+20, marker4+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<21; i++){
			Table.set("Count", i, "NA");
		}
	}

}//no reference marker near DNA
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell");
	Table.set("Slice", n+1, reference_marker+" Cell ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" Cell");
	Table.set("Slice", n+4, marker1+" Cell ROI");
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" Cell");
	Table.set("Slice", n+9, marker2+" Cell ROI");
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+14, marker3);
	Table.set("Slice", n+15, marker3+" Cell");
	Table.set("Slice", n+16, marker3+" Cell ROI");
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+18, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+19, marker4);
	Table.set("Slice", n+20, marker4+" Cell");
	Table.set("Slice", n+21, marker4+" Cell ROI");
	Table.set("Slice", n+22, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+23, marker4+" colocalised "+reference_marker+ " ROI");
	for (i=2; i<24; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no reference marker in the image
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" Cell");
	Table.set("Slice", n+2, reference_marker+" Cell ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" Cell");
	Table.set("Slice", n+5, marker1+" Cell ROI");
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+8, marker2);
	Table.set("Slice", n+9, marker2+" Cell");
	Table.set("Slice", n+10, marker2+" Cell ROI");
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+13, marker3);
	Table.set("Slice", n+14, marker3+" Cell");
	Table.set("Slice", n+15, marker3+" Cell ROI");
	Table.set("Slice", n+16, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+18, marker4);
	Table.set("Slice", n+19, marker4+" Cell");
	Table.set("Slice", n+20, marker4+" Cell ROI");
	Table.set("Slice", n+21, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+22, marker4+" colocalised "+reference_marker+ " ROI");
	for (i=3; i<23; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no DNA in the region of interest 
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, "nucleus");
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" Cell");
	Table.set("Slice", n+3, reference_marker+" Cell ROI");
	Table.set("Slice", n+4, marker1);
	Table.set("Slice", n+5, marker1+" Cell");
	Table.set("Slice", n+6, marker1+" Cell ROI");
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+8, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+9, marker2);
	Table.set("Slice", n+10, marker2+" Cell");
	Table.set("Slice", n+11, marker2+" Cell ROI");
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+13, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+14, marker3);
	Table.set("Slice", n+15, marker3+" Cell");
	Table.set("Slice", n+16, marker3+" Cell ROI");
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+18, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+19, marker4);
	Table.set("Slice", n+20, marker4+" Cell");
	Table.set("Slice", n+21, marker4+" Cell ROI");
	Table.set("Slice", n+22, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+23, marker4+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<24; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no region of interest in the image
else {
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest);
	Table.set("Slice", 1, "nucleus");
	Table.set("Slice", 2, reference_marker);
	Table.set("Slice", 3, reference_marker+" Cell");
	Table.set("Slice", 4, reference_marker+" Cell ROI");
	Table.set("Slice", 5, marker1);
	Table.set("Slice", 6, marker1+" Cell");
	Table.set("Slice", 7, marker1+" Cell ROI");
	Table.set("Slice", 8, marker1+" colocalised "+reference_marker);
	Table.set("Slice", 9, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 10, marker2);
	Table.set("Slice", 11, marker2+" Cell");
	Table.set("Slice", 12, marker2+" Cell ROI");
	Table.set("Slice", 13, marker2+" colocalised "+reference_marker);
	Table.set("Slice", 14, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 15, marker3);
	Table.set("Slice", 16, marker3+" Cell");
	Table.set("Slice", 17, marker3+" Cell ROI");
	Table.set("Slice", 18, marker3+" colocalised "+reference_marker);
	Table.set("Slice", 19, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 20, marker4);
	Table.set("Slice", 21, marker4+" Cell");
	Table.set("Slice", 22, marker4+" Cell ROI");
	Table.set("Slice", 23, marker4+" colocalised "+reference_marker);
	Table.set("Slice", 24, marker4+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<25; i++){
			Table.set("Count", i, "NA");
		}
	}


IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "fourmarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}


//////////////////////////////////////////////5MARKERS//////////////////////////////////////////////////


function Five_markers(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Reference marker has DNA marker ot identify nucleus?
open(subdir+"DNA.tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2&3
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");
open(subdir+marker3+".tif");
open(subdir+marker4+".tif");
open(subdir+marker5+".tif");

run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
//if plaque present
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


selectWindow("DNA.tif"); /// Should always have DNA name 
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(DNA_thresh+" dark");
run("Convert to Mask");
run("Watershed");
selectWindow("DNA.tif");

run("Analyze Particles...", "size=DNA_area-Infinity pixel show=Masks summarize"); //check image with a lot of cells, might see two nuclei count as one, or one nucleus split into fragments 
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , "nucleus");
	
selectWindow("Mask of DNA.tif");
run("Create Selection");
//if there are cells
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "DNA");

roiManager("Select", 2);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "DNA_enlarged");

roiManager("Select", newArray(1,2)); //finding nucleus within given radius of ROI 
roiManager("AND");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_region_interest"); // DNA in plaque region
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "yellow");
roiManager("Set Line Width", 2);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius pixel");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "DNA_RoI_enlarged");

//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 2, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");

//if reference marker present
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+reference_marker);
RoiManager.setPosition(0);
roiManager("Select", count-1);

roiManager("Select", newArray(2,7)); //Reference signal overlapping with enlarged DNA
roiManager("AND");
//if there is reference signal around DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);
selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker + " Cell");
rename(reference_marker+" Cells");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");

roiManager("Select", newArray(4,8)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//if there is reference marker around the region of interest 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

selectWindow("Mask of DNA.tif");
count = roiManager("count");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" Cell ROI");
rename(reference_marker+" Cell ROI");
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker1);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker1 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" Cell ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER 1 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" colocalised "+reference_marker+ " ROI");
  }
//if no marker1 positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker1 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+" Cell");
	Table.set("Slice", n+1 , marker1+" Cell ROI");
	Table.set("Slice", n+2,  marker1+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" Cell");
	Table.set("Slice", n+2 , marker1+" Cell ROI");
	Table.set("Slice", n+3,  marker1+" colocalised "+reference_marker+ " ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");

//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker2);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker2 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK MARKER2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK MARKER2 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker 2 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" colocalised "+reference_marker+ " ROI");
	}
//if no marker 2 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+" Cell");
	Table.set("Slice", n+1, marker2+" Cell ROI");
	Table.set("Slice", n+2, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" Cell");
	Table.set("Slice", n+2, marker2+" Cell ROI");
	Table.set("Slice", n+3, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker2+" colocalised "+reference_marker+ " ROI");
	}
	
//// MARKER 3

selectWindow(marker3+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m3_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m3_area-Infinity pixel show=Masks summarize"); //get marker3 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3);
selectWindow("Mask of "+marker3+".tif");
run("Create Selection");

//if there are marker3 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker3);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker3 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker3+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK marker3 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK marker3 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK marker3 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker3 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+" colocalised "+reference_marker+ " ROI");
	}
//if no marker3 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+" Cell");
	Table.set("Slice", n+1, marker3+" Cell ROI");
	Table.set("Slice", n+2, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker3+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker3 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3);
	Table.set("Slice", n+1, marker3+" Cell");
	Table.set("Slice", n+2, marker3+" Cell ROI");
	Table.set("Slice", n+3, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker3+" colocalised "+reference_marker+ " ROI");
	}
////end marker 3

/// MARKER 4

selectWindow(marker4+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m4_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m4_area-Infinity pixel show=Masks summarize"); //get marker4 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4);
selectWindow("Mask of "+marker4+".tif");
run("Create Selection");

//if there are marker4 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker4);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker4 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker4+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK marker4 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker4 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK marker4 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker4 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK marker4 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker4 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4+" colocalised "+reference_marker+ " ROI");
	}
//if no marker4 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4+" Cell");
	Table.set("Slice", n+1, marker4+" Cell ROI");
	Table.set("Slice", n+2, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker4+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker4 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4);
	Table.set("Slice", n+1, marker4+" Cell");
	Table.set("Slice", n+2, marker4+" Cell ROI");
	Table.set("Slice", n+3, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker4+" colocalised "+reference_marker+ " ROI");
	}

////end marker 4

//marker 5

selectWindow(marker5+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m5_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m5_area-Infinity pixel show=Masks summarize"); //get marker5 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5);
selectWindow("Mask of "+marker5+".tif");
run("Create Selection");

//if there are marker5 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker5);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", count-1);
run("Enlarge...", "enlarge=coloc_radius");
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", "enlarged_"+marker5);
RoiManager.setPosition(0);
roiManager("Select", count-1);


roiManager("Select", newArray(2,count-1)); 
roiManager("AND");
//if there is marker5 near DNA
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker5+"_cell");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of DNA.tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker5+" Cell");

roiManager("Select", newArray((count-1),4));
roiManager("AND");
// CHECK marker5 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker5+"_cell_ROI");
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5+" Cell ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+" Cell ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+" Cell ROI");
}

roiManager("Select", newArray((count-2),8)); //Overlap of marker5 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");
// CHECK marker5 REF Colocalisation
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker5+reference_marker);
  selectWindow("Mask of DNA.tif");
  roiManager("Select", count-1);
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5+" colocalised "+reference_marker);
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+" colocalised "+reference_marker);
}

roiManager("Select", newArray((count-3),9)); //Overlap of marker5 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK marker5 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker5+reference_marker+"_roi");
  selectWindow("Mask of DNA.tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5+" colocalised "+reference_marker+ " ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+" colocalised "+reference_marker+ " ROI");
  }
//if no positive ref marker5 cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker5+" colocalised "+reference_marker+ " ROI");
	}
//if no marker5 near DNA
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker5+" Cell");
	Table.set("Slice", n+1, marker5+" Cell ROI");
	Table.set("Slice", n+2, marker5+" colocalised "+reference_marker);
	Table.set("Slice", n+3, marker5+" colocalised "+reference_marker+ " ROI");;
	}
//if no marker5 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker5);
	Table.set("Slice", n+1, marker5+" Cell");
	Table.set("Slice", n+2, marker5+" Cell ROI");
	Table.set("Slice", n+3, marker5+" colocalised "+reference_marker);
	Table.set("Slice", n+4, marker5+" colocalised "+reference_marker+ " ROI");
	}

////end marker 5

//no reference marker in region of interest 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" Cell");
	Table.set("Slice", n+3, marker1+" Cell ROI");
	Table.set("Slice", n+4, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" Cell");
	Table.set("Slice", n+8, marker2+" Cell ROI");
	Table.set("Slice", n+9, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+11, marker3);
	Table.set("Slice", n+12, marker3+" Cell");
	Table.set("Slice", n+13, marker3+" Cell ROI");
	Table.set("Slice", n+14, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+15, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+16, marker4);
	Table.set("Slice", n+17, marker4+" Cell");
	Table.set("Slice", n+18, marker4+" Cell ROI");
	Table.set("Slice", n+19, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+20, marker4+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+21, marker5);
	Table.set("Slice", n+22, marker5+" Cell");
	Table.set("Slice", n+23, marker5+" Cell ROI");
	Table.set("Slice", n+24, marker5+" colocalised "+reference_marker);
	Table.set("Slice", n+25, marker5+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<26; i++){
			Table.set("Count", i, "NA");
		}
	}

}//no reference marker near DNA
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" Cell");
	Table.set("Slice", n+1, reference_marker+" Cell ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" Cell");
	Table.set("Slice", n+4, marker1+" Cell ROI");
	Table.set("Slice", n+5, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" Cell");
	Table.set("Slice", n+9, marker2+" Cell ROI");
	Table.set("Slice", n+10, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+12, marker3);
	Table.set("Slice", n+13, marker3+" Cell");
	Table.set("Slice", n+14, marker3+" Cell ROI");
	Table.set("Slice", n+15, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+16, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+17, marker4);
	Table.set("Slice", n+18, marker4+" Cell");
	Table.set("Slice", n+19, marker4+" Cell ROI");
	Table.set("Slice", n+20, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+21, marker4+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+22, marker5);
	Table.set("Slice", n+23, marker5+" Cell");
	Table.set("Slice", n+24, marker5+" Cell ROI");
	Table.set("Slice", n+25, marker5+" colocalised "+reference_marker);
	Table.set("Slice", n+26, marker5+" colocalised "+reference_marker+ " ROI");
	for (i=2; i<27; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no reference marker in the image
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" Cell");
	Table.set("Slice", n+2, reference_marker+" Cell ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" Cell");
	Table.set("Slice", n+5, marker1+" Cell ROI");
	Table.set("Slice", n+6, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+8, marker2);
	Table.set("Slice", n+9, marker2+" Cell");
	Table.set("Slice", n+10, marker2+" Cell ROI");
	Table.set("Slice", n+11, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+13, marker3);
	Table.set("Slice", n+14, marker3+" Cell");
	Table.set("Slice", n+15, marker3+" Cell ROI");
	Table.set("Slice", n+16, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+18, marker4);
	Table.set("Slice", n+19, marker4+" Cell");
	Table.set("Slice", n+20, marker4+" Cell ROI");
	Table.set("Slice", n+21, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+22, marker4+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+23, marker5);
	Table.set("Slice", n+24, marker5+" Cell");
	Table.set("Slice", n+25, marker5+" Cell ROI");
	Table.set("Slice", n+26, marker5+" colocalised "+reference_marker);
	Table.set("Slice", n+27, marker5+" colocalised "+reference_marker+ " ROI");
	for (i=3; i<28; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no DNA 
else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, "nucleus");
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" Cell");
	Table.set("Slice", n+3, reference_marker+" Cell ROI");
	Table.set("Slice", n+4, marker1);
	Table.set("Slice", n+5, marker1+" Cell");
	Table.set("Slice", n+6, marker1+" Cell ROI");
	Table.set("Slice", n+7, marker1+" colocalised "+reference_marker);
	Table.set("Slice", n+8, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+9, marker2);
	Table.set("Slice", n+10, marker2+" Cell");
	Table.set("Slice", n+11, marker2+" Cell ROI");
	Table.set("Slice", n+12, marker2+" colocalised "+reference_marker);
	Table.set("Slice", n+13, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+14, marker3);
	Table.set("Slice", n+15, marker3+" Cell");
	Table.set("Slice", n+16, marker3+" Cell ROI");
	Table.set("Slice", n+17, marker3+" colocalised "+reference_marker);
	Table.set("Slice", n+18, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+19, marker4);
	Table.set("Slice", n+20, marker4+" Cell");
	Table.set("Slice", n+21, marker4+" Cell ROI");
	Table.set("Slice", n+22, marker4+" colocalised "+reference_marker);
	Table.set("Slice", n+23, marker4+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", n+24, marker5);
	Table.set("Slice", n+25, marker5+" Cell");
	Table.set("Slice", n+26, marker5+" Cell ROI");
	Table.set("Slice", n+27, marker5+" colocalised "+reference_marker);
	Table.set("Slice", n+28, marker5+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<29; i++){
			Table.set("Count", i, "NA");
		}
	}
}//no region of interest in the image
else {
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest);
	Table.set("Slice", 1, "nucleus");
	Table.set("Slice", 2, reference_marker);
	Table.set("Slice", 3, reference_marker+" Cell");
	Table.set("Slice", 4, reference_marker+" Cell ROI");
	Table.set("Slice", 5, marker1);
	Table.set("Slice", 6, marker1+" Cell");
	Table.set("Slice", 7, marker1+" Cell ROI");
	Table.set("Slice", 8, marker1+" colocalised "+reference_marker);
	Table.set("Slice", 9, marker1+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 10, marker2);
	Table.set("Slice", 11, marker2+" Cell");
	Table.set("Slice", 12, marker2+" Cell ROI");
	Table.set("Slice", 13, marker2+" colocalised "+reference_marker);
	Table.set("Slice", 14, marker2+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 15, marker3);
	Table.set("Slice", 16, marker3+" Cell");
	Table.set("Slice", 17, marker3+" Cell ROI");
	Table.set("Slice", 18, marker3+" colocalised "+reference_marker);
	Table.set("Slice", 19, marker3+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 20, marker4);
	Table.set("Slice", 21, marker4+" Cell");
	Table.set("Slice", 22, marker4+" Cell ROI");
	Table.set("Slice", 23, marker4+" colocalised "+reference_marker);
	Table.set("Slice", 24, marker4+" colocalised "+reference_marker+ " ROI");
	Table.set("Slice", 25, marker5);
	Table.set("Slice", 26, marker5+" Cell");
	Table.set("Slice", 27, marker5+" Cell ROI");
	Table.set("Slice", 28 marker5+" colocalised "+reference_marker);
	Table.set("Slice", 29, marker5+" colocalised "+reference_marker+ " ROI");
	for (i=1; i<30; i++){
			Table.set("Count", i, "NA");
		}
	}


IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "fivemarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////// No DNA Marker ///////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////1MARKER///////////////////////////////////////////////

function One_marker_noDNA(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc marker 1
open(subdir+marker1+".tif");



run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
//If ROI
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 1, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");
// If ref present
if ( selectionType() != -1) {

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);


roiManager("Select", newArray(1,count-1)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//If ref ROI region
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);


count = roiManager("count");
roiManager("Select", count-1);
if (has_roi=="Yes"){
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n , reference_marker+" ROI");
}
rename(reference_marker+" ROI");
//run("Gaussian Blur...", "sigma=1");
//run("Make Binary");
//run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_ROI");
  selectWindow("Mask of "+marker1+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker1 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+reference_marker);

roiManager("Select", newArray(3,count-1)); //Ref plaque AND marker
roiManager("AND");

// CHECK MARKER 1 REF POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+reference_marker+" ROI");
	}
//if no marker 1 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+reference_marker);
	Table.set("Slice", n+1,  marker1+reference_marker+" ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" ROI");
	Table.set("Slice", n+2, marker1+reference_marker);
	Table.set("Slice", n+3, marker1+reference_marker+" ROI");
	}
//End marker1
//If no ref ROi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" ROI");
	Table.set("Slice", n+3, marker1+reference_marker);
	Table.set("Slice", n+4, marker1+reference_marker+" ROI");
	for (i=1; i<5; i++){
			Table.set("Count", i, "NA");
		}
}
// If no ref
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" ROI");
	Table.set("Slice", n+4, marker1+reference_marker);
	Table.set("Slice", n+5, marker1+reference_marker+" ROI");
	for (i=2; i<6; i++){
			Table.set("Count", i, "NA");
		}
}
//If no roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, region_of_interest);
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" ROI");
	Table.set("Slice", n+5, marker1+reference_marker);
	Table.set("Slice", n+6, marker1+reference_marker+" ROI");
	for (i=1; i<7; i++){
			Table.set("Count", i, "NA");
		}
}

IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "onemarker.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}

////////////////////////////////////////////////2MARKERS//////////////////////////////////////////////


function Two_markers_noDNA(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");


run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
// if roi
if ( selectionType() != -1) {
	
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 1, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");
//if ref present
if ( selectionType() != -1) {

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);


roiManager("Select", newArray(1,count-1)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
// if ref roi
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);


count = roiManager("count");
roiManager("Select", count-1);
if (has_roi=="Yes"){
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n , reference_marker+" ROI");
}
rename(reference_marker+" ROI");
if(reference_marker=="Iba1"){
run("Gaussian Blur...", "sigma=1");
run("Make Binary");
run("Watershed");
}


//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_ROI");
  selectWindow("Mask of "+marker1+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker1 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+reference_marker+" ROI");
	}
//if no marker 1 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+reference_marker);
	Table.set("Slice", n+1,  marker1+reference_marker+" ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" ROI");
	Table.set("Slice", n+2, marker1+reference_marker);
	Table.set("Slice", n+3, marker1+reference_marker+" ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m2_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");
//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_ROI");
  selectWindow("Mask of "+marker2+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker2 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker2+reference_marker+" ROI");
	}
//if no marker 2 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+reference_marker);
	Table.set("Slice", n+1,  marker2+reference_marker+" ROI");
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" ROI");
	Table.set("Slice", n+2, marker2+reference_marker);
	Table.set("Slice", n+3, marker2+reference_marker+" ROI");
	}
//End marker2
//if no ref
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" ROI");
	Table.set("Slice", n+3, marker1+reference_marker);
	Table.set("Slice", n+4, marker1+reference_marker+" ROI");
	Table.set("Slice", n+5, marker2);
	Table.set("Slice", n+6, marker2+" ROI");
	Table.set("Slice", n+7, marker2+reference_marker);
	Table.set("Slice", n+8, marker2+reference_marker+" ROI");
	for (i=1; i<9; i++){
			Table.set("Count", i, "NA");
		}
}
//if no ref roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" ROI");
	Table.set("Slice", n+4, marker1+reference_marker);
	Table.set("Slice", n+5, marker1+reference_marker+" ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" ROI");
	Table.set("Slice", n+8, marker2+reference_marker);
	Table.set("Slice", n+9, marker2+reference_marker+" ROI");
	for (i=2; i<10; i++){
			Table.set("Count", i, "NA");
		}
}
//if no roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, region_of_interest);
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" ROI");
	Table.set("Slice", n+5, marker1+reference_marker);
	Table.set("Slice", n+6, marker1+reference_marker+" ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" ROI");
	Table.set("Slice", n+9, marker2+reference_marker);
	Table.set("Slice", n+10, marker2+reference_marker+" ROI");
	for (i=1; i<11; i++){
			Table.set("Count", i, "NA");
		}
}

IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "twomarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}


//////////////////////////////////////////////3MARKERS//////////////////////////////////////////////////


function Three_markers_noDNA(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2&3
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");
open(subdir+marker3+".tif");

run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
//if roi
if ( selectionType() != -1) {
	
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 1, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");
//if ref
if ( selectionType() != -1) {

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);


roiManager("Select", newArray(1,count-1)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
//if ref roi
if ( selectionType() != -1) {
	
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);


count = roiManager("count");
roiManager("Select", count-1);
if (has_roi=="Yes"){
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n , reference_marker+" ROI");
}
rename(reference_marker+" ROI");
//run("Gaussian Blur...", "sigma=1");
//run("Make Binary");
//run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_ROI");
  selectWindow("Mask of "+marker1+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker1 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+reference_marker+" ROI");
	}
//if no marker 1 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+reference_marker);
	Table.set("Slice", n+1,  marker1+reference_marker+" ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" ROI");
	Table.set("Slice", n+2, marker1+reference_marker);
	Table.set("Slice", n+3, marker1+reference_marker+" ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m2_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");
//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_ROI");
  selectWindow("Mask of "+marker2+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker2 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+reference_marker+" ROI");
  }
//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker2+reference_marker+" ROI");
	}
//if no marker 2 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+reference_marker);
	Table.set("Slice", n+1,  marker2+reference_marker+" ROI");
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" ROI");
	Table.set("Slice", n+2, marker2+reference_marker);
	Table.set("Slice", n+3, marker2+reference_marker+" ROI");
	}
	
//// MARKER 3

selectWindow(marker3+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m3_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m3_area-Infinity pixel show=Masks summarize"); //get marker3 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3);
selectWindow("Mask of "+marker3+".tif");
run("Create Selection");
//if there are marker3 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 3 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+"_ROI");
  selectWindow("Mask of "+marker3+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker3 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker3+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 3 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker3+reference_marker+" ROI");
	}
//if no marker 3 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+reference_marker);
	Table.set("Slice", n+1,  marker3+reference_marker+" ROI");
	}
//if no marker 3 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3);
	Table.set("Slice", n+1, marker3+reference_marker);
	Table.set("Slice", n+2, marker3+reference_marker+" ROI");
	}

////end marker 3
//no ref roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" ROI");
	Table.set("Slice", n+3, marker1+reference_marker);
	Table.set("Slice", n+4, marker1+reference_marker+" ROI");
	Table.set("Slice", n+5, marker2);
	Table.set("Slice", n+6, marker2+" ROI");
	Table.set("Slice", n+7, marker2+reference_marker);
	Table.set("Slice", n+8, marker2+reference_marker+" ROI");
	Table.set("Slice", n+9, marker3);
	Table.set("Slice", n+10, marker3+" ROI");
	Table.set("Slice", n+11, marker3+reference_marker);
	Table.set("Slice", n+12, marker3+reference_marker+" ROI");
	for (i=1; i<13; i++){
			Table.set("Count", i, "NA");
		}
	
}
//no ref
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" ROI");
	Table.set("Slice", n+4, marker1+reference_marker);
	Table.set("Slice", n+5, marker1+reference_marker+" ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" ROI");
	Table.set("Slice", n+8, marker2+reference_marker);
	Table.set("Slice", n+9, marker2+reference_marker+" ROI");
	Table.set("Slice", n+10, marker3);
	Table.set("Slice", n+11, marker3+" ROI");
	Table.set("Slice", n+12, marker3+reference_marker);
	Table.set("Slice", n+13, marker3+reference_marker+" ROI");
	for (i=2; i<14; i++){
			Table.set("Count", i, "NA");
		}
}
//no roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, region_of_interest);
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" ROI");
	Table.set("Slice", n+5, marker1+reference_marker);
	Table.set("Slice", n+6, marker1+reference_marker+" ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" ROI");
	Table.set("Slice", n+9, marker2+reference_marker);
	Table.set("Slice", n+10, marker2+reference_marker+" ROI");
	Table.set("Slice", n+11, marker3);
	Table.set("Slice", n+12, marker3+" ROI");
	Table.set("Slice", n+13, marker3+reference_marker);
	Table.set("Slice", n+14, marker3+reference_marker+" ROI");
	for (i=1; i<15; i++){
			Table.set("Count", i, "NA");
		}
}


IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "threemarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}


//////////////////////////////////////////////4MARKERS//////////////////////////////////////////////////


function Four_markers_noDNA(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");

// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2&3
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");
open(subdir+marker3+".tif");
open(subdir+marker4+".tif");

run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");
// if roi
if ( selectionType() != -1) {
	
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 1, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");
//if ref
if ( selectionType() != -1) {

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);


roiManager("Select", newArray(1,count-1)); //Cells with reference signal overlapping with enlarged DNA within ROI region 
roiManager("AND");
// if ref roi
if ( selectionType() != -1) {
	
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);


count = roiManager("count");
roiManager("Select", count-1);
if (has_roi=="Yes"){
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n , reference_marker+" ROI");
}
rename(reference_marker+" ROI");
//run("Gaussian Blur...", "sigma=1");
//run("Make Binary");
//run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_ROI");
  selectWindow("Mask of "+marker1+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker1 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+reference_marker+" ROI");
	}
//if no marker 1 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+reference_marker);
	Table.set("Slice", n+1,  marker1+reference_marker+" ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" ROI");
	Table.set("Slice", n+2, marker1+reference_marker);
	Table.set("Slice", n+3, marker1+reference_marker+" ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m2_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");
//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_ROI");
  selectWindow("Mask of "+marker2+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker2 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker2+reference_marker+" ROI");
	}
//if no marker 2 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+reference_marker);
	Table.set("Slice", n+1,  marker2+reference_marker+" ROI");
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" ROI");
	Table.set("Slice", n+2, marker2+reference_marker);
	Table.set("Slice", n+3, marker2+reference_marker+" ROI");
	}
	
//// MARKER 3

selectWindow(marker3+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m3_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m3_area-Infinity pixel show=Masks summarize"); //get marker3 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3);
selectWindow("Mask of "+marker3+".tif");
run("Create Selection");
//if there are marker3 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 3 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+"_ROI");
  selectWindow("Mask of "+marker3+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker3 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker3+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 3 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker3+reference_marker+" ROI");
	}
//if no marker 3 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+reference_marker);
	Table.set("Slice", n+1,  marker3+reference_marker+" ROI");
	}
//if no marker 3 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3);
	Table.set("Slice", n+1, marker3+" ROI");
	Table.set("Slice", n+2, marker3+reference_marker);
	Table.set("Slice", n+3, marker3+reference_marker+" ROI");
	}

////end marker 3

/// MARKER 4

selectWindow(marker4+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m4_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m4_area-Infinity pixel show=Masks summarize"); //get marker4 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4);
selectWindow("Mask of "+marker4+".tif");
run("Create Selection");
//if there are marker4 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 4 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+"_ROI");
  selectWindow("Mask of "+marker4+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" ROI");
}else{ 
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker4 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker4+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker4 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 4 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker4+reference_marker+" ROI");
	}
//if no marker 4 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4+reference_marker);
	Table.set("Slice", n+1,  marker4+reference_marker+" ROI");
	}
//if no marker 4 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4);
	Table.set("Slice", n+1, marker4+" ROI");
	Table.set("Slice", n+2, marker4+reference_marker);
	Table.set("Slice", n+3, marker4+reference_marker+" ROI");
	}

////end marker 4
// no ref roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" ROI");
	Table.set("Slice", n+3, marker1+reference_marker);
	Table.set("Slice", n+4, marker1+reference_marker+" ROI");
	Table.set("Slice", n+5, marker2);
	Table.set("Slice", n+6, marker2+" ROI");
	Table.set("Slice", n+7, marker2+reference_marker);
	Table.set("Slice", n+8, marker2+reference_marker+" ROI");
	Table.set("Slice", n+9, marker3);
	Table.set("Slice", n+10, marker3+" ROI");
	Table.set("Slice", n+11, marker3+reference_marker);
	Table.set("Slice", n+12, marker3+reference_marker+" ROI");
	Table.set("Slice", n+13, marker4);
	Table.set("Slice", n+14, marker4+" ROI");
	Table.set("Slice", n+15, marker4+reference_marker);
	Table.set("Slice", n+16, marker4+reference_marker+" ROI");
	for (i=1; i<17; i++){
			Table.set("Count", i, "NA");
		}
	
}
//no ref
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" ROI");
	Table.set("Slice", n+4, marker1+reference_marker);
	Table.set("Slice", n+5, marker1+reference_marker+" ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" ROI");
	Table.set("Slice", n+8, marker2+reference_marker);
	Table.set("Slice", n+9, marker2+reference_marker+" ROI");
	Table.set("Slice", n+10, marker3);
	Table.set("Slice", n+11, marker3+" ROI");
	Table.set("Slice", n+12, marker3+reference_marker);
	Table.set("Slice", n+13, marker3+reference_marker+" ROI");
	Table.set("Slice", n+14, marker4);
	Table.set("Slice", n+15, marker4+" ROI");
	Table.set("Slice", n+16, marker4+reference_marker);
	Table.set("Slice", n+17, marker4+reference_marker+" ROI");
	for (i=2; i<18; i++){
			Table.set("Count", i, "NA");
		}
}
//no roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, region_of_interest);
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" ROI");
	Table.set("Slice", n+5, marker1+reference_marker);
	Table.set("Slice", n+6, marker1+reference_marker+" ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" ROI");
	Table.set("Slice", n+9, marker2+reference_marker);
	Table.set("Slice", n+10, marker2+reference_marker+" ROI");
	Table.set("Slice", n+11, marker3);
	Table.set("Slice", n+12, marker3+" ROI");
	Table.set("Slice", n+13, marker3+reference_marker);
	Table.set("Slice", n+14, marker3+reference_marker+" ROI");
	Table.set("Slice", n+15, marker4);
	Table.set("Slice", n+16, marker4+" ROI");
	Table.set("Slice", n+17, marker4+reference_marker);
	Table.set("Slice", n+18, marker4+reference_marker+" ROI");
	for (i=1; i<19; i++){
			Table.set("Count", i, "NA");
		}
}

IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "fourmarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}


//////////////////////////////////////////////5MARKERS//////////////////////////////////////////////////


function Five_markers_noDNA(subdir) {
	
// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");

 // set UI to invisible

//item = Array.concat("plaque","nucleus","Iba1","Iba1_Ab","CD68","CD68+Iba1","HLADR","HLADR+Iba1");

// Reference marker 
open(subdir+reference_marker+".tif");


// Region of interest
if (has_roi=="Yes"){
// Region of interest
open(subdir+region_of_interest+".tif");
}else if (has_roi=="No"){
	newImage("No_ROI.tif", "8-bit white", 500, 500, 1);
	region_of_interest="No_ROI";
}

// Coloc markers 1&2&3
open(subdir+marker1+".tif");
open(subdir+marker2+".tif");
open(subdir+marker3+".tif");
open(subdir+marker4+".tif");
open(subdir+marker5+".tif");

run("Set Scale...", "distance=1 known=1 unit=micrometer global");
selectWindow(region_of_interest+".tif");
setOption("ScaleConversions", true);
run("8-bit");
setAutoThreshold("Triangle dark");
if(roi_gaus=="Yes"){
run("Gaussian Blur...", "sigma=5");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold("Triangle dark");
}else{
setOption("BlackBackground", false);
setAutoThreshold(roi_thresh+" dark");	
}
run("Convert to Mask");
if(roi_gaus=="Yes"){
run("Watershed");
}
run("Analyze Particles...", "size=roi_area-Infinity pixel show=Masks summarize");
	selectWindow("Summary");
	Table.set("Slice", 0, region_of_interest); /// region of interest = plaques
selectWindow("Mask of "+region_of_interest+".tif");
run("Create Selection");

// If there is ROI signal
if ( selectionType() != -1) {
run("ROI Manager...");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", region_of_interest);
roiManager("Select", 0);
run("Enlarge...", "enlarge=radius pixel");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", region_of_interest+radius+"microns");


//Reference marker
selectWindow(reference_marker+".tif");
setOption("ScaleConversions", true);
run("8-bit");
//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(ref_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=ref_area-Infinity pixel show=Masks summarize"); //get the total area of Iba1, but not total number of microglia, because the microglia signal become fragments, overlap with total nucleus to get count if needed?
	selectWindow("Summary");
	Table.set("Slice", 1, reference_marker);
selectWindow("Mask of "+reference_marker+".tif");
run("Create Selection");
//If there is reference marker signal
if ( selectionType() != -1) {

roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker);


roiManager("Select", newArray(1,count-1)); //Cells with reference signal within ROI region 
roiManager("AND");
//If there is reference marker in the ROI
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", reference_marker+"_roi");
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);


count = roiManager("count");
roiManager("Select", count-1);
if (has_roi=="Yes"){
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); //get the nucleus ROI which has Iba1 signal inside
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , reference_marker+" ROI");
}else{
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n , reference_marker+" ROI");
}
rename(reference_marker+" ROI");
//run("Gaussian Blur...", "sigma=1");
//run("Make Binary");
//run("Watershed");



//Marker1
selectWindow(marker1+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m1_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m1_area-Infinity pixel show=Masks summarize"); //get marker1 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1);
selectWindow("Mask of "+marker1+".tif");
run("Create Selection");
//if there are marker1 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 1 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+"_ROI");
  selectWindow("Mask of "+marker1+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker1 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker1+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker1+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker1 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 1 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker1+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker1+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker1+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker1+reference_marker+" ROI");
	}
//if no marker 1 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1+reference_marker);
	Table.set("Slice", n+1,  marker1+reference_marker+" ROI");
	}
//if no marker 1 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker1);
	Table.set("Slice", n+1, marker1+" ROI");
	Table.set("Slice", n+2, marker1+reference_marker);
	Table.set("Slice", n+3, marker1+reference_marker+" ROI");
	}

// MARKER 2

selectWindow(marker2+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m2_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m2_area-Infinity pixel show=Masks summarize"); //get marker2 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2);
selectWindow("Mask of "+marker2+".tif");
run("Create Selection");
//if there are marker2 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 2 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+"_ROI");
  selectWindow("Mask of "+marker2+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker2 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker2+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker2+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker2 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 2 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker2+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker2+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker2+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker2+reference_marker+" ROI");
	}
//if no marker 2 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2+reference_marker);
	Table.set("Slice", n+1,  marker2+reference_marker+" ROI");
	}
//if no marker 2 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker2);
	Table.set("Slice", n+1, marker2+" ROI");
	Table.set("Slice", n+2, marker2+reference_marker);
	Table.set("Slice", n+3, marker2+reference_marker+" ROI");
	}
	
//// MARKER 3

selectWindow(marker3+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m3_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m3_area-Infinity pixel show=Masks summarize"); //get marker3 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3);
selectWindow("Mask of "+marker3+".tif");
run("Create Selection");
//if there are marker3 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 3 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+"_ROI");
  selectWindow("Mask of "+marker3+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker3 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker3+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker3+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker3 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 3 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker3+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker3+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker3+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker3+reference_marker+" ROI");
	}
//if no marker 3 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3+reference_marker);
	Table.set("Slice", n+1,  marker3+reference_marker+" ROI");
	}
//if no marker 3 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker3);
	Table.set("Slice", n+1, marker3+" ROI");
	Table.set("Slice", n+2, marker3+reference_marker);
	Table.set("Slice", n+3, marker3+reference_marker+" ROI");
	}

////end marker 3

/// MARKER 4

selectWindow(marker4+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m4_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m4_area-Infinity pixel show=Masks summarize"); //get marker4 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4);
selectWindow("Mask of "+marker4+".tif");
run("Create Selection");
//if there are marker4 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 4 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+"_ROI");
  selectWindow("Mask of "+marker4+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+" ROI");
}else{ 
	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" ROI");
}
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker4 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker4+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker4+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker4 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 4 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker4+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if(has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker4+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker4+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker4+reference_marker+" ROI");
	}
//if no marker 4 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4+reference_marker);
	Table.set("Slice", n+1,  marker4+reference_marker+" ROI");
	}
//if no marker 4 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker4);
	Table.set("Slice", n+1, marker4+" ROI");
	Table.set("Slice", n+2, marker4+reference_marker);
	Table.set("Slice", n+3, marker4+reference_marker+" ROI");
	}

////end marker 4

//marker 5

selectWindow(marker5+".tif");
setOption("ScaleConversions", true);
run("8-bit");

//run("Threshold...");
setOption("BlackBackground", false);
setAutoThreshold(m5_thresh+" dark");
run("Convert to Mask");
run("Analyze Particles...", "size=m5_area-Infinity pixel show=Masks summarize"); //get marker5 total area
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5);
selectWindow("Mask of "+marker5+".tif");
run("Create Selection");
//if there are marker5 signal 
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker5);
roiManager("Set Color", "red");
roiManager("Set Line Width", 1);

roiManager("Select", newArray((count-1),1));
roiManager("AND");
// CHECK MARKER 5 ROI
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker5+"_ROI");
  selectWindow("Mask of "+marker5+".tif");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+" ROI");
  }
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+" ROI");
}

roiManager("Select", newArray(2,count-2)); 
roiManager("AND");
//if there is marker5 overlapping ref
if ( selectionType() != -1) {
roiManager("Add");
count = roiManager("count");
roiManager("Select", count-1);
roiManager("Rename", marker5+reference_marker);
roiManager("Select", count-1);
RoiManager.setPosition(0);
roiManager("Set Color", "red");
roiManager("Set Line width", 1);

selectWindow("Mask of "+reference_marker+".tif");
roiManager("Select", count-1);
run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize");
    selectWindow("Summary");
    n = Table.size;
    Table.set("Slice", n-1 , marker5+reference_marker);

roiManager("Select", newArray(3,count-1)); //Overlap of marker5 enlarged, reference within roi enlarged, and DNA within roi enlarged
roiManager("AND");

// CHECK MARKER 5 POSITIVE REGION
if ( selectionType() != -1) {
  roiManager("Add");
  count = roiManager("count");
  roiManager("Select", count-1);
  roiManager("Rename", marker5+reference_marker+"_roi");
  selectWindow(reference_marker+" ROI");
  count = roiManager("count");
  roiManager("Select", count-1);
  if (has_roi=="Yes"){
  run("Analyze Particles...", "size=2-Infinity pixel show=Masks summarize"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n-1 , marker5+reference_marker+" ROI");
  }else{
  	run("Analyze Particles...", "size=2-Infinity pixel show=Masks"); 
  	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n , marker5+reference_marker+" ROI");
  }

//if no positive cells in ROI
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n,  marker5+reference_marker+" ROI");
	}
//if no marker 5 overlapping ref
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker5+reference_marker);
	Table.set("Slice", n+1,  marker5+reference_marker+" ROI");
	}
//if no marker 5 signal 
}else {
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, marker5);
	Table.set("Slice", n+1, marker5+" ROI");
	Table.set("Slice", n+2, marker5+reference_marker);
	Table.set("Slice", n+3, marker5+reference_marker+" ROI");
	}

////end marker 5
//if no ref roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker+" ROI");
	Table.set("Slice", n+1, marker1);
	Table.set("Slice", n+2, marker1+" ROI");
	Table.set("Slice", n+3, marker1+reference_marker);
	Table.set("Slice", n+4, marker1+reference_marker+" ROI");
	Table.set("Slice", n+5, marker2);
	Table.set("Slice", n+6, marker2+" ROI");
	Table.set("Slice", n+7, marker2+reference_marker);
	Table.set("Slice", n+8, marker2+reference_marker+" ROI");
	Table.set("Slice", n+9, marker3);
	Table.set("Slice", n+10, marker3+" ROI");
	Table.set("Slice", n+11, marker3+reference_marker);
	Table.set("Slice", n+12, marker3+reference_marker+" ROI");
	Table.set("Slice", n+13, marker4);
	Table.set("Slice", n+14, marker4+" ROI");
	Table.set("Slice", n+15, marker4+reference_marker);
	Table.set("Slice", n+16, marker4+reference_marker+" ROI");
	Table.set("Slice", n+17, marker5);
	Table.set("Slice", n+18, marker5+" ROI");
	Table.set("Slice", n+19, marker5+reference_marker);
	Table.set("Slice", n+20, marker5+reference_marker+" ROI");
	for (i=1; i<21; i++){
			Table.set("Count", i, "NA");
		}
	
}
//if no ref
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, reference_marker);
	Table.set("Slice", n+1, reference_marker+" ROI");
	Table.set("Slice", n+2, marker1);
	Table.set("Slice", n+3, marker1+" ROI");
	Table.set("Slice", n+4, marker1+reference_marker);
	Table.set("Slice", n+5, marker1+reference_marker+" ROI");
	Table.set("Slice", n+6, marker2);
	Table.set("Slice", n+7, marker2+" ROI");
	Table.set("Slice", n+8, marker2+reference_marker);
	Table.set("Slice", n+9, marker2+reference_marker+" ROI");
	Table.set("Slice", n+10, marker3);
	Table.set("Slice", n+11, marker3+" ROI");
	Table.set("Slice", n+12, marker3+reference_marker);
	Table.set("Slice", n+13, marker3+reference_marker+" ROI");
	Table.set("Slice", n+14, marker4);
	Table.set("Slice", n+15, marker4+" ROI");
	Table.set("Slice", n+16, marker4+reference_marker);
	Table.set("Slice", n+17, marker4+reference_marker+" ROI");
	Table.set("Slice", n+18, marker5);
	Table.set("Slice", n+19, marker5+" ROI");
	Table.set("Slice", n+20, marker5+reference_marker);
	Table.set("Slice", n+21, marker5+reference_marker+" ROI");
	for (i=2; i<22; i++){
			Table.set("Count", i, "NA");
		}
}
//if no roi
}else{
	selectWindow("Summary");
	n = Table.size;
	Table.set("Slice", n, region_of_interest);
	Table.set("Slice", n+1, reference_marker);
	Table.set("Slice", n+2, reference_marker+" ROI");
	Table.set("Slice", n+3, marker1);
	Table.set("Slice", n+4, marker1+" ROI");
	Table.set("Slice", n+5, marker1+reference_marker);
	Table.set("Slice", n+6, marker1+reference_marker+" ROI");
	Table.set("Slice", n+7, marker2);
	Table.set("Slice", n+8, marker2+" ROI");
	Table.set("Slice", n+9, marker2+reference_marker);
	Table.set("Slice", n+10, marker2+reference_marker+" ROI");
	Table.set("Slice", n+11, marker3);
	Table.set("Slice", n+12, marker3+" ROI");
	Table.set("Slice", n+13, marker3+reference_marker);
	Table.set("Slice", n+14, marker3+reference_marker+" ROI");
	Table.set("Slice", n+15, marker4);
	Table.set("Slice", n+16, marker4+" ROI");
	Table.set("Slice", n+17, marker4+reference_marker);
	Table.set("Slice", n+18, marker4+reference_marker+" ROI");
	Table.set("Slice", n+19, marker5);
	Table.set("Slice", n+20, marker5+" ROI");
	Table.set("Slice", n+21, marker5+reference_marker);
	Table.set("Slice", n+22, marker5+reference_marker+" ROI");
	for (i=1; i<23; i++){
			Table.set("Count", i, "NA");
		}
}
IJ.renameResults("Summary", "Results");
saveAs("Results", subdir + "fivemarkers.csv");

// empty the ROI manager
roiManager("reset");
// empty the results table
run("Clear Results");
run("Close All");
}