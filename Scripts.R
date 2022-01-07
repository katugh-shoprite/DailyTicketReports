library(tidyverse)

SAPAnalyticsReport <- read_csv("C:/Users/katugh/Documents/GIT Repo/Daily Reports/Input/SAPAnalyticsReport(TicketStatusReport).csv") %>%
                      select(-'Service Level') %>%
                      rename('Service Level' = ...4)

TicketStatus <- SAPAnalyticsReport %>%
      filter(`Ticket Type` == "Careline") %>%
      select(Agent, `Ticket ID`, `Service Level`, `Changed On`, `Service Category`, `Incident Category`, Object, Origin, `Case Title`,
           Status, Priority, `Created On`, `Completion Date`)

UnassignedTickets <- SAPAnalyticsReport %>%
      select(Agent, `Ticket ID`, `Ticket Type`, `Changed On`, `Service Category`, `Incident Category`, Object, Origin, `Case Title`,
          Status, Priority, `Created On`, `Completion Date`)

write_csv(TicketStatus, "C:/Users/katugh/Documents/GIT Repo/Daily Reports/Output/TicketStatus.csv")

write_csv(UnassignedTickets, "C:/Users/katugh/Documents/GIT Repo/Daily Reports/Output/UnassignedTickets.csv")
