#
# Read Files into R from this directory
#
# "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/"
#
# Set Directory and Run #
#
dataDir <- "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/"
RunNum  <- 574480851
RunNum  <- 574458732
#
# This is an attempt to read an arg for a run number
# from Console:
#      source("ModelOutputCode.R") 
# only gets default Run Number
# this
#      system("rscript ModelOutputCode.R 574448898")
# allows run # to change (but windows pop up, outside of studio)
#
args = commandArgs(trailingOnly=TRUE)
if (length(args)>0) {
  RunNum <- args[1]
}
#
# Initialize Allowed File Extensions
#
fileEnds <- c(".AG43_SS_EB.csv", 
              ".C3P2_SS_EB.csv", 
              ".Cohort_Category.csv", 
              ".EB_CY.csv", 
              ".EB_OUTPUT.csv",
              ".EB_Captive_Output_Report.csv",
              ".Fin_Rep_Stat_Forecast.csv",
              ".Fin_Rep_GAAP_Forecast.csv", 
              ".GAAP_Cohort_Category.csv",
              ".GAAP_Cohort_Category_Forecast.csv",
              ".GAAP_Details_Category_Forecast.csv",
              ".GAAP_SOP_by_Scenario_Report.csv", 
              ".ScenarioSet.csv")
#
# Initializae Run Info
#
RunInfo       <- NULL
RunInfoExtra  <- NULL
RunInfoExtra2 <- NULL
#
# Read Run Info Files
#
fileName <- paste(dataDir, "RunInfo.", RunNum, ".csv", sep="")
if (file.exists(fileName))  RunInfo  <- read.csv(fileName)

fileName <- paste(dataDir, "RunInfoExtra.", RunNum, ".csv", sep="")
if (file.exists(fileName))  RunInfoExtra <- read.csv(fileName)

fileName <- paste(dataDir, "RunInfoExtra2.", RunNum, ".csv", sep="")
if (file.exists(fileName))  RunInfoExtra2 <- read.csv(fileName)
#
# Initialize Model Information Stores
#
ModKey      <- NULL
ModGroup    <- NULL
ModVar      <- NULL
#
# Read and Merge ModKey, ModGroup and ModVar Files
#
for (i in 1:length(fileEnds)) {
  #
  # ModKey
  #
  fileName <- paste(dataDir, "ModKey.", RunNum, fileEnds[i], sep="")
  if (file.exists(fileName)) {
    ModKeyTmp <- read.csv(fileName)
    if (is.null(ModKey)) {
      ModKey <- ModKeyTmp
    } else {
      ModKey <- merge(ModKey,  ModKeyTmp, all.x=TRUE, all.y=TRUE)
    }
  }
  #
  # ModGroup
  #
  fileName <- paste(dataDir, "ModGroup.", RunNum, fileEnds[i], sep="")
  if (file.exists(fileName)) {
    ModGroupTmp <- read.csv(fileName)
    if (is.null(ModGroup)) {
      ModGroup <- ModGroupTmp
    } else {
      ModGroup    <- merge(ModGroup, ModGroupTmp, all.x=TRUE, all.y=TRUE)
    }
  }
  #
  # ModVar
  #
  fileName <- paste(dataDir, "ModVar.", RunNum, fileEnds[i], sep="")
  if (file.exists(fileName)) {
    ModVarTmp <- read.csv(fileName)
    if (is.null(ModVar)) {
      ModVar <- ModVarTmp
    } else {
      ModVar    <- merge(ModVar,  ModVarTmp, all.x=TRUE, all.y=TRUE)
    }
  }
}
#
# End Loop over file extensions
# Clean-up temp variables
#
rm(ModKeyTmp)
rm(ModGroupTmp)
rm(ModVarTmp)

#
# View Data
#
#View(RunInfo)
#View(RunInfoExtra)
#View(RunInfoExtra2)
#
#View(ModKey)
#View(ModGroup)
#View(ModVar)
#
# End View
#
# Load and View Variable Definitions from Excel File
#
VariableDefs <- NULL
fileName <- paste(dataDir, "VariableDefs.xlsx", sep="")
if (file.exists(fileName)) {
  Sys.setenv("JAVA_HOME" = "C:\\Program Files\\Java\\jre1.8.0_151")
  library("xlsx", lib.loc="~/R/win-library/3.4")
  VariableDefs<-read.xlsx(fileName, sheetIndex = 1)
}
#View(VariableDefs)
#
# Write something
#
cat("Run: ", RunInfo$RunId, " JobId: ", RunInfo$JobId, " Source System:", as.character(RunInfo$SourceSystemCode))
cat(" For ", as.character(VariableDefs$VariableName[VariableDefs$ModelVariableId==1758]))
cat(" Mean is ", mean(ModVar$VariableValue[ModVar$ModelVariableId==1757]) )
#
# end