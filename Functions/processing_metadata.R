library(readr)
library(stringr)

metadata=read_csv('metadata.csv')
metadata$trem2_all=ifelse(metadata$TREM2Variant=='none','CV','TREM2')

metadata$CaseID=str_replace(metadata$CaseID, pattern='/', replacement='.')
metadata$CaseID=str_replace(metadata$CaseID, pattern='-', replacement='.')
metadata$CaseID=str_replace(metadata$CaseID, pattern=fixed('*'), replacement= '')
metadata=metadata[c('CaseID1',"CaseID","AD/CTRL","TREM2Variant",'APOE','PostMortemDelayHours','trem2_all','BraakID','Sex','Age')]
metadata=metadata[!duplicated(metadata$CaseID),]
metadata$PostMortemDelayHours=as.numeric(metadata$PostMortemDelayHours)
metadata$pmi_median=ifelse(metadata$PostMortemDelayHours>median(metadata$PostMortemDelayHours, na.rm = TRUE),'High_pmi','Low_pmi')
metadata$pmi_median=as.factor(metadata$pmi_median)

write_csv(metadata,"metadata.csv")
