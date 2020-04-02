## SF Restaurant Data: https://data.sfgov.org/Health-and-Social-Services/Restaurant-Scores-LIVES-Standard/pyih-qa8i


library(tidyverse)
library(lubridate)

dat <- read_csv("data/Restaurant_Scores_-_LIVES_Standard.csv.gz")

## outcome: risk_category

dat %>%
        filter(business_latitude > 0, !is.na(risk_category)) %>%
        ggplot(aes(business_longitude, business_latitude)) + 
        geom_point(aes(color = risk_category)) + 
        coord_fixed()

dat %>%
        mutate(inspection_date = mdy_hms(inspection_date)) %>%
        ggplot(aes(inspection_date, inspection_score)) + 
        geom_point()
