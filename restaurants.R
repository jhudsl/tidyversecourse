## SF Restaurant Data: https://data.sfgov.org/Health-and-Social-Services/Restaurant-Scores-LIVES-Standard/pyih-qa8i


library(tidyverse)
library(lubridate)

dat <- read_csv("data/Restaurant_Scores_-_LIVES_Standard.csv.gz") %>%
        mutate(risk = fct_collapse(risk_category,
                                   high = "High Risk",
                                   other_level = "low"),
               zip = factor(business_postal_code),
               date = as.Date(mdy_hms(inspection_date)))

## outcome: risk_category

dat %>%
        filter(business_latitude > 0, !is.na(risk_category)) %>%
        ggplot(aes(business_longitude, business_latitude)) + 
        geom_point(aes(color = risk_category)) + 
        coord_fixed()

dat %>%
        filter(!is.na(violation_description)) %>%
        select(business_id, inspection_type, risk)

dat %>%
        filter(!is.na(risk)) %>%
        group_by(inspection_type) %>%
        summarize(riskp = mean(risk == "high", na.rm = TRUE)) %>%
        arrange(desc(riskp))

dat %>%
        mutate(inspection_date = mdy_hms(inspection_date)) %>%
        ggplot(aes(inspection_date, inspection_score)) + 
        geom_point() + 
        geom_smooth()

fit <- glm(risk ~ date,
           data = dat, 
           family = binomial)

tidy(fit) %>%
        as.data.frame()
        
