#Load packages
library("RSQLite")

#Set working directory
setwd("pathname")

#Set the database interface driver
drv <- dbDriver("SQLite")

#Open a connection to survey.db
survey <- dbConnect(drv, "survey.db")

#List the tables
dbListTables(survey)

#List the fields for specific tables
dbListFields(survey, "Survey")

#Get data from the database
surveyData <- dbGetQuery(survey, "Select * from Survey")
