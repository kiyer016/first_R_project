#load the dplyr package
library("dplyr")

#load the csv file
dat <- read.csv("data/gapminder_data.csv")

mean(dat$gdpPercap)
mean(dat[1:5,"gdpPercap"])
mean(dat[dat$continent == "Americas","gdpPercap"])
#### using dpylr for data subsetting ----
# 'filter' chooses the rows 
filter(dat,continent == "Americas")
filter(dat,year > 2000)
dat_2 <- filter(dat,continent == "Americas",year > 2000)

#'select' chooses the columns
select(dat,continent)
select(dat_2,country,year,gdpPercap)

# %>% is the pipe that works same as in the unix shell
dat %>%
    filter(continent =="Americas", year > 2000) %>% 
    select(country,year,gdpPercap)
#### group_by() and summarize ----
summary_1 <- dat %>% 
    group_by(country) %>% 
    summarize(avg_life_exp = mean(lifeExp))
#### Challenge Question 1 ----
# 1. Compute the average gdpPercap for each country
# 2. Compute the gdpPercap for each continent in year 1957

summary_2 <- dat %>% 
  group_by(country) %>% 
  summarize(gdpcap = mean(gdpPercap))

summary_3 <- dat %>% 
  group_by(continent) %>% 
  filter(year == 1957) %>% 
  summarize(gdpcap = mean(gdpPercap))

#### multiple summary outputs ----
dat %>% 
    group_by(continent) %>% 
    summarise(avg_gdp = mean(gdpPercap),
              min_gdp = min(gdpPercap),
              median_gdp = median(gdpPercap),
              sd_gdp = sd(gdpPercap),
              num_values = n())
#### making new column variables %>% ----
dat %>% 
    mutate(gdp_billion = gdpPercap* 10^9)


#### wide vs long in gapminder data ----
dat2 <-  dat %>% 
    select(country,year,gdpPercap)
library(tidyr)
dat_2_wide <- dat2 %>% 
  spread(year,gdpPercap)
dat_2_long <- dat_2_wide %>% 
    gather(year,gdp,"1952":"2007")
            