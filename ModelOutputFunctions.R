#
# Actuarial Functions for Model Ouput
#
# Tim Hessing
# 4/12/2018
#
# Complete execution would be
# ---------------------------
# source("ModelOutputFunctions.R")
# rn <- "an integer run number"
# dd <- "a character string for data directory"
# #
# # Get Run Information
# #
# runInfo   <- getRunInfo(rn, dd)
# runExtra  <- getRunScenarios(rn, dd)
# runExtra2 <- getRunObjects(rn, dd)
# #
# # Get Run Data
# #
# ModelKey   <- getModelKey(rn, dd)
# ModelGroup <- getModelGroup(rn, dd)
# ModelVar   <- getModelVar(rn, dd)
# #
# # Get Variable Definitions (from spreadsheet)
# # Ned xlsx library to read spreadsheet
# #
# library("xlsx", lib.loc="~/R/win-library/3.4")
# VarDef <- getVarIdDef(dd)
# #
# # Merge Data
# #
# ModelOut <- mergeModel(ModelKey, ModelGroup, ModelVar, VarDef)
# #
# # Perform a simple Calculation
# #
# newOut <- calcGMDBTreatyClaimLimit(ModelOut)
# #
# # Merge Calc with rest of Output
# #
# ModelOut <- merge(ModelOut, newOut, all.x=TRUE, all.y=TRUE)
# #
#
#
# ================
#
# Get Run Info
#
getRunInfo <- function(runNum  = 574458732, 
                       dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/",
                       fileStart = "RunInfo.") {
  #
  # Initialize Return Value to NULL
  #
  RunInfo <- NULL
  if (fileStart == "RunInfo." ||
      fileStart == "RunInfoExtra." ||
      fileStart == "RunInfoExtra2.") {
    
    #
    # Read Run Info Files
    #
    fileName <- paste(dataDir, fileStart, runNum, ".csv", sep="")
    if (file.exists(fileName)) RunInfo <- read.csv(fileName, stringsAsFactors = FALSE)
  } # endif
  #
  # Return Result
  #
  RunInfo
} # end function
#
# ================
#
# Get Run Scenario Information
#
getRunScenarios <- function(runNum  = 574458732, 
                            dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/") {
  #
  # Read & Return Run Scenario Files
  #
  RunInfo  <- getRunInfo(runNum, dataDir, "RunInfoExtra.")
} # end function
#
# ================
#
# Get Run Object Information
#
getRunObjects <- function(runNum  = 574458732, 
                          dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/") {
  #
  # Read & Return Run Object Files
  #
  RunInfo  <- getRunInfo(runNum, dataDir, "RunInfoExtra2.")
} # end function
#
# ================
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
# ================
#
# Get Model Data
#
getModelData <- function(runNum  = 574458732, 
                         dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/",
                         fileStart = "ModKey.") {
  #
  # Initialize Return Value to NULL
  #
  ModelData <- NULL
  if (fileStart == "ModKey." ||
      fileStart == "ModGroup." ||
      fileStart == "ModVar.") {
    #
    # Read and Merge Model Data Files
    #
    for (i in 1:length(fileEnds)) {
      fileName <- paste(dataDir, fileStart, runNum, fileEnds[i], sep="")
      if (file.exists(fileName)) {
        ModelTmp <- read.csv(fileName, stringsAsFactors = FALSE)
        #
        # First time set equal, after that merge
        #
        if (is.null(ModelData)) {
          ModelData <- ModelTmp
        } else {
          ModelData <- merge(ModelData,  ModelTmp, all.x=TRUE, all.y=TRUE)
        } # end if NULL
      } # end if File Exists
    } # end for-loop over file extensions
  } # end if file start names
  #
  # Return Result
  #
  ModelData
} # end function
#
# ================
#
# Get Model Key Information
#
getModelKey <- function(runNum  = 574458732, 
                        dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/") {
  #
  # Read & Return Run Object Files
  #
  ModelData  <- getModelData(runNum, dataDir, "ModKey.")
} # end function
#
# ================
#
# Get Model Group Information
#
getModelGroup <- function(runNum  = 574458732, 
                          dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/") {
  #
  # Read & Return Run Object Files
  #
  ModelData  <- getModelData(runNum, dataDir, "ModGroup.")
} # end function
#
# ================
#
# Get Model Variable Information
#
getModelVar <- function(runNum  = 574458732, 
                        dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/") {
  #
  # Read & Return Run Object Files
  #
  ModelData  <- getModelData(runNum, dataDir, "ModVar.")
} # end function
#
# ================
#
# Get Variable ID Information
#
getVarIdDef <- function(dataDir = "//actlusers/actl-users/PUCCIJ/PublicWrite/For Tim/") {
  #
  # Load and View Variable Definitions from Excel File
  #
  VarIdDef <- NULL
  fileName <- paste(dataDir, "VariableDefs.xlsx", sep="")
  if (file.exists(fileName)) {
    #
    # Set Environment
    #
    Sys.setenv("JAVA_HOME" = "C:\\Program Files\\Java\\jre1.8.0_151")
    library("xlsx", lib.loc="~/R/win-library/3.4")
    #
    # Read Spreadsheet
    #
    VarIdDef <- read.xlsx(fileName, sheetIndex = 1)
  } # end if
  VarIdDef
} # end function
#
# ================
#
#
#
resetColumns <- function(ModelOut) {
  #
  # Keep non-redundant columns and Re-order
  #
  ModelOut <- ModelOut[, c("SourceSystemId", "ModelRunId", "ModelKeyId",
                           "GroupId", "ModelGroupType", "GroupDesc",  
                           "InnerScenarioId", "InnerScenarioDate", 
                           "OuterScenarioId", "OuterScenarioDate", 
                           "ModelVariableId", "VariableName", "VariableDesc", "VariableValue")]
  #
  # Return Result
  #
}
# ================
#
# Merge Model Information
#
mergeModel <- function(ModKey, ModGroup, ModVar, VarIdDef) {
  #
  # Merge Data on Key & Group by GroupId then with Var by KeyId
  #
  ModelOut <- merge(merge(merge(ModKey, ModGroup, by.x = "GroupId",         by.y = "GroupId"), 
                                          ModVar, by.x = "ModelKeyId",      by.y = "ModelKeyId"),
                                        VarIdDef, by.x = "ModelVariableId", by.y = "ModelVariableId")
  #
  # Rename "SourceSystemId.x" column to eliminate ".x"
  #
  names(ModelOut)[names(ModelOut) == "SourceSystemId.x"] <- paste("SourceSystemId")
  #
  # Reset and re-order columns
  #
  ModelOut <- resetColumns(ModelOut)
  #
  # Return Result
  #
  ModelOut
}
#
# ================
#
# Return or Calculate Funds Released on Death
#
calcGMDBTreatyClaimLimit <- function(ModelOut) {
  #
  # Define Variables IDs needed in Calc
  #
  varIDLst <- c(1367, 1380,
                1406, 1419, 1432, 1445, 1458, 1471,
                1790, 
                1829, 1866,
                1910, 1915, 1950,
                2022)
  #
  # Get Data subset with variable ID
  #
  datSubset <-ModelOut[(ModelOut$ModelVariableId %in% varIDLst), names(ModelOut)]
  #
  # assuming calculation is an aggregate by 
  #
  sumBy <- list(SourceSystemId = datSubset$SourceSystemId,
                ModelRunId = datSubset$ModelRunId,
                ModelKeyId = datSubset$ModelKeyId,
                GroupId = datSubset$GroupId,
                ModelGroupType = datSubset$ModelGroupType,
                GroupDesc = datSubset$GroupDesc,
                InnerScenarioId = datSubset$InnerScenarioId,
                InnerScenarioDate = datSubset$InnerScenarioDate, 
                OuterScenarioId = datSubset$OuterScenarioId,
                OuterScenarioDate = datSubset$OuterScenarioDate)
  #
  newOut<-aggregate(datSubset$VariableValue, by=sumBy, FUN=sum)
  #
  # Rename last Column appropriately
  #
  names(newOut)[length(newOut)] <- paste("VariableValue")
  #
  # Add new Variable ID, Name and Desc and Reorder Columns
  #
  newOut$ModelVariableId <- 200114
  newOut$VariableName    <- "CALC_GMDB Claim Adj for Limit"
  newOut$VariableDesc    <- "TBD"
  #
  # Reset and re-order columns
  #
  newOut <- resetColumns(newOut)
  #
  # Return Result
  #
  newOut
} # end function
  