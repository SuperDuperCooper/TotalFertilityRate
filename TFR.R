#######################The Human Fertility Database#############

#Things to figure out:
#1- Will any automatic comment reflow I have on my r program transfer over to whoever marks my work? 
#2- Should I write comments before or after the code? I naturally put them after, but notice Emma puts them before
#3- How to make arrows on the shiny powerpoint?
#Can I add labels onto a streamgraph? (I expect I can add them manually if not through streamgraph code)


###############About the Data###########
#Total Fertility Rate
#The average number of children who would be born alive to a woman during her lifetime, if the age-specific fertility rates of a given year remained constant during her childbearing years. It is computed as the sum of fertility rates by age across all childbearing ages in a given year.
############Plan/ to do############
#Make a shiny powerpoint
#Include a moving graph


############Required Packages###################
library(tidyverse)
library(janitor)
library(readxl)
library(writexl)
library(streamgraph)
library(plotly)
library(htmlwidgets)
#devtools::install_github("hrbrmstr/streamgraph")

###########Opening the file############

rawtfr <- read_excel("Data/TFR.xlsx", sheet = "Total fertility rates") %>% 
  janitor::clean_names()

#The organisation in this data could be better. I want to remove the second column, relabel the column names and tidy it up. 

######Renaming the column names###########
name <- array(rawtfr[1,])
rawtfr <- read_excel("TFR.xlsx", sheet = "Total fertility rates",
                        col_names = FALSE,
                        skip = 3) %>% 
  janitor::clean_names()
names(rawtfr) <- name
#The UK and Germany are counted multiple times into separate countries/ parts. I would like to remove the additional parts.
rawtfr<- rawtfr[,-c(14,15, 34:36)]
str(rawtfr)

##############Tidying the file#################
tfr <- rawtfr %>% 
  pivot_longer(names_to = "Country",
               values_to = "TFR",
               cols= -c("COUNTRY"))
names(tfr)[1]<- "Year"
write_xlsx(tfr,"Processed_TFR.xlsx")

#Want to ommit the rows with NA
tfr[tfr==0] <- NA
tfr<-tfr[complete.cases(tfr),]

#First attempt at a Streamgraph (totally wrong, but awesome!)
streamgraph(tfr, key= "Country", value= "TFR", date= "Year")%>%
  sg_legend(show=T, label= "Country:")
# save the widget
# library(htmlwidgets)
# saveWidget(pp, file=paste0( getwd(), "/HtmlWidget/streamgraphDropdown.html"))

#32 countries but says there are 1655 characters. 
str(tfr)



#Making a ggplot of the data!
#As there's so much data, I decided to make the plot interactive so you could look at certain points better
plot<- ggplot(tfr, aes(x= Year, y=TFR, group= Country, colour= Country))+
  geom_point()+
  geom_line()+
  scale_colour_manual(values= rainbow(32))+
  scale_y_discrete(breaks=seq(0, 5, 0.1))+
  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggplotly(plot)

#What i want to do next:
#- make a statistical analysis of the total fertility rates, compare a few countries (maybe focus on the UK a little bit and see how that is?)
#- read through the rmds/ each workshop, make sure have rmd file correct

#########References##############
#Human Fertility Database. Max Planck Institute for Demographic Research (Germany) and Vienna Institute of Demography (Austria). Available at www.humanfertility.org (data downloaded on 08/01/21).


