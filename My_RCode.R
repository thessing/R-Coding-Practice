##
## Example
##
## Author - Tim Hessing
##
## Description - This is an example R script to play with
##
#
# Define Working Directory
#
path <- "C:/Users/hessit1/Desktop"
#
# Set Working Directory
#
getwd()
setwd(path)
getwd()
#
# Define Months Vector (mths)
#
mths <- c("January", 
          "February", 
          "March", 
          "April", 
          "May", 
          "June", 
          "July", 
          "August", 
          "September", 
          "October", 
          "November", 
          "December" )
#
# Load Data
#
insure <- read.table('data.csv', header = TRUE)
#
# Header Columns
#	AccountingMonth_Id
#	AccountingYearMonth"
#	Process_Platform"
#	Product"
#	Contract"
#	InsuredItem"
#	AddressLine"
#	Zip_Cd"
#	Zip4_Cd"
#	ZipPlus4"
#	ZipPlus4Dash"
#	Misc1"
#
insure$AccountingYearMonth[10]
insure$Process_Platform[10]
insure$Zip_Cd[10]
insure$Zip4_Cd[10]
di=dim(insure)
boolzip <- logical(di[1])
for(i in 1:di[1]) if (insure$Zip4_Cd[i] != '@') boolzip[i] <- TRUE else boolzip[i] <- FALSE
histogram(insure$Zip_Cd)
ep[1] <- 0
ep[2] <- 99999
histogram(insure$Zip_Cd, type='percent', endpoints=ep)
histogram(insure$Zip_Cd, type='percent', endpoints=ep, breaks=5)

# http://confserver.ent.nwie.net/proxy/outbound.pac
# http://http-proxy.nwie.net

# opts <- list(
# proxy         = "",
# proxyusername = "hessit1", 
# proxypassword = "********", 
# proxyport     = 8080
# )
# options(RCurlOptions = opts)

# curl_with_proxy <- function(url, verbose = TRUE){
#  proxy <- ie_get_proxy_for_url(url)
#  h <- new_handle(verbose = verbose, proxy = proxy)
#  curl(url, handle = h)
# }

# con <- curl_with_proxy("https://httpbin.org/get")
# readLines(con)

# Sys.setenv(http_proxy_user = "hessit1:pwd")
# Sys.setenv(http_proxy = "http-proxy.nwie.net:8080")
# Sys.setenv(http_proxy_auth = "ntlm")

# config_proxy <- use_proxy(url = curl::ie_get_proxy_for_url(),auth ="ntlm", user = "hessit1", password = "****")
# GET(url="www.coursera.org", config_proxy)
# httr::config(config_proxy)

# library(bitops)
# library(RCurl)
# library(curl)
# library(httr)
# library(testthat)
# set_config(config(ssl_verifypeer=0L))
# library(swirl)
# swirl()
 
# install.packages("stringi", type = "source")
# install.packages("swirl")
# library(swirl)
# install.packages("curl")
# library(curl)
# install_course_zip("swirl_courses-master.zip", multi=TRUE, which_course="R Programming")
# swirl()

#11 & 16
O_dat <- read.csv("quiz1_data/hw1_data.csv")
summary(O_dat)

#12
head(O_dat)

#13 & 14
tail(O_dat)

#15
O_dat$Ozone[47]

#17
mean(O_dat$Ozone[!is.na(O_dat$Ozone[])])

#18
mean(O_dat$Solar.R[!is.na(O_dat$Ozone[]) & O_dat$Ozone[]>31 & O_dat$Temp[]>90])

#19.
mean(O_dat$Temp[O_dat$Month == 6])

# 20.
max(O_dat$Ozone[!is.na(O_dat$Ozone[]) & O_dat$Month==5])

