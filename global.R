#demo of Motion Charts
library(googleVis)
library(xlsx)
library(reshape2)
library(dplyr)
library(ggplot2)

#read in the GDP file and assign it to a dataframe called dfGDP
dfGDP <- read.xlsx("GDP Data 1.0.xlsx", sheetIndex=2, endRow=185, colIndex=c(1:13))
#look at the STRucture of the 
str(dfGDP)
#change the columns to pure text (aka "character")
dfGDP[,2:13] <- as.data.frame(lapply(dfGDP[,2:13], as.character))
#now make the text values numeric
for(i in 2:13) {
  dfGDP[,i] <- as.character(dfGDP[,i])
}

#select the desired countries
countries1 <- names(dfGDP)
countries <- countries1[c(2,3,5,6,7,8,10,11,13)]
#now put the GDP file into "long" form, using the melt function from package reshape2

dfGDP2 <- melt(data=dfGDP, id.vars="Year")
#select the countries required for the analysis
dfGDP2 <- droplevels(dfGDP2[dfGDP2$variable %in% countries,])
dfGDP2$value <- as.numeric(dfGDP2$value)
#get the country names to match the other country names
levels(dfGDP2$variable)[levels(dfGDP2$variable)=="Total.Former.USSR"] <- "F..USSR"
levels(dfGDP2$variable)[levels(dfGDP2$variable)=="United.Kingdom"] <- "UK"

#read in the population table
df_pop_all <- read.xlsx("Pop1.xlsx", sheetIndex=1, endRow=181, colIndex=c(1:10))
names(df_pop_all)
df_pop_all2 <- melt(data=df_pop_all,id.vars="Year")

#read in infant mortality
df_inf_mor_all <- read.xlsx("ALL EURO.xlsx", sheetIndex=1, endRow=174, colIndex=c(1:10))

names(df_inf_mor_all)




#transform infant mortality data frame into long form 

df_inf_mor2 <- melt(data=df_inf_mor_all, id.vars="year")

names(dfGDP2)[3] <- "pc_GDP"
names(df_inf_mor2)[3] <- "inf_mort"
names(df_pop_all)[3] <- "pop"

names(df_inf_mor2)[1] <- "Year"
names(df_inf_mor2)[2] <- "variable"
pc_GDP_inf <- left_join(dfGDP2, df_inf_mor2, by=c("Year", "variable"))
df_this_is_not_a_drill <- left_join(pc_GDP_inf, df_pop_all2, by=c("Year", "variable"))



names(df_this_is_not_a_drill)[2] <- "Country"
names(df_this_is_not_a_drill)[5] <- "Pop"  

MReal <- gvisMotionChart(df_this_is_not_a_drill, idvar="Country", timevar="Year",
                         options=list(width=900,height=600))
plot(MReal)

