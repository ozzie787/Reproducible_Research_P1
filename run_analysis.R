#******************************************************************************
# NOTE: Comments are listed as sublevels of a main comment. They are used to  *
#       outline the processes used throughout this script and how they relate *
#       to one another.                                                       *
#                                                                             *
#       EXAMPLE: # A Comment such as a main process               (Top level) *
#                # > This is a subprocess                           (Level 1) *
#                # >> This is a subprocess of a subprocess          (Level 2) *
#                # A second main process                          (Top level) *
#                # > This is a subprocess                           (Level 1) *
#                # A Comment such as a third main process         (Top level) *
#                # > This is a subprocess                           (Level 1) *
#                # >> This is a subprocess of a subprocess          (Level 2) *
#                ... etc.                                           (Level N) *
#                                                                             *
#******************************************************************************

# Load required libraries
library(data.table)
library(dplyr)
library(tidyr)
library(lubridate)

# Download and extract data
# > If not downloaded, download the data. If downloaded, move on.
if (!file.exists("data.zip")) {
     message("Downloading data from 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", dest="data.zip", dest="data.zip'... Please wait")
     download.file(url = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", dest="data.zip", dest = "data.zip", method = "curl")
} else {
     message("Data already downloaded as data.zip")
}

# > If data is downloaded and not extracted, extract the ZIP archive. If extracted, move on.
if (file.exists("data.zip") & !file.exists("activity.csv")) {
     message("Extracting data... Please wait")
     unzip("data.zip")
} else {
     message("Data already extracted to ./activity.csv")
}

data <- read.csv("activity.csv")

week_day <- c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")

data2 <- mutate(
     data,
     steps   = replace_na(steps,0),
     w_day   = week_day[wday(date)],
     time_hr = floor(interval/100),
     time_mn = interval%%100
     )

