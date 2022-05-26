library(stringr)
library(tidyverse)

#function to get username
user <- function(wd){
  user_name <- wd %>%
    str_remove("C:/Users/") 
  
  substring(user_name,1, regexpr("/", user_name)-1)
}

dt <- Sys.Date()
username <- user(getwd())
report_path <- paste0("C:/Users/",username,"/OneDrive - Shoprite Checkers (Pty) Limited/Reporting Files and Documents/Ticket Status Report/")

SAPAnalyticsReport <- read_csv("Input/SAPAnalyticsReport(TicketStatusReport).csv") %>%
  select(-'Service Level') %>%
  rename('Service Level' = ...4)

write_csv(SAPAnalyticsReport, paste0("C:/Users/",username,"/OneDrive - Shoprite Checkers (Pty) Limited/Reporting Files and Documents/Ticket Status Report/Archive/SAPAnalyticsReport(TicketStatusReport ",dt,").csv"))

TicketStatus <- SAPAnalyticsReport %>%
  filter(`Ticket Type` == "Careline") %>%
  select(Agent, `Ticket ID`, `Service Level`, `Changed On`, `Service Category`, `Incident Category`, Object, Origin, `Case Title`,
         Status, Priority, `Created On`, `Completion Date`)

UnassignedTickets <- SAPAnalyticsReport %>%
  filter(`Ticket Type` != "Employee Support Ticket") %>%
  select(Agent, `Ticket ID`, `Ticket Type`, `Changed On`, `Service Category`, `Incident Category`, Object, Origin, `Case Title`,
         Status, Priority, `Created On`, `Completion Date`)

write_csv(TicketStatus, paste0(report_path,"Output/TicketStatus ", dt,".csv"))
write_csv(UnassignedTickets, paste0(report_path,"Output/UnassignedTickets ", dt,".csv"))
