library(tidyr)
library(ggplot2)
library(dplyr)
library(ggmagnify)
library(readr)
options(scipen=999)

# Download the data from: 
gdp <- read_csv("worldbank/API_NY.GDP.MKTP.CD_DS2_en_csv_v2_5358352.csv", skip = 3, show_col_types = FALSE)
head(gdp)

# Create an intermediate data frame with only the columns I want
gdp_intermediate <- as.data.frame(subset(gdp, select=c("Country Name", "Country Code", "2000":"2021")))
# Rename the columns with spaces in the names. Why do people do that? 
colnames(gdp_intermediate)[1:2] <- c("country_name", "country_code")
# Filter based on the countries we want to plot
gdp_intermediate <- gdp_intermediate %>% filter (country_name %in% c("United States", "China", "Germany", "France", "United Kingdom"))
# This calculates the GDP growth based on the year 2000.
gdp_intermediate <- gdp_intermediate %>% mutate(across(c(3:24), ~ . / `2000`))

# Change the data frame from wide to long
gdp_long <- gather(gdp_intermediate, gdp_year, gdp_value, '2000':'2021', factor_key=FALSE)
gdp_long$gdp_year <- as.integer(gdp_long$gdp_year)

# Use ggplot2 followed by ggmagnify 
p <- ggplot(gdp_long, aes(x=gdp_year, y=gdp_value, group=country_name)) + 
  geom_line(aes(color=country_name)) + 
  geom_point(aes(color=country_name, shape=country_name), size=1.5) +
  scale_color_brewer(palette="Set1") + theme_minimal() +
  labs(x = "GDP Year", y = "GDP Growth", color = "Country", 
       shape="Country", title = "GDP Growth from 2000 to 2021", 
       caption = "Graphic by: Megan Payne | Data: WorldBank.org | #30DayChartChallenge Day 30") + 
  scale_shape_manual(values = c(5, 17, 7, 19, 4)) + 
  theme(plot.caption = element_text(hjust = 0))
p

# Add the magnification using ggmagnify. 
# The xlim, ylim determine which part of the graph is magnified. 
# The inset_xlim, inset_ylim give the coordinates of the inset location.
# axes = TRUE to label the inset
ggm <- ggmagnify(p,
    xlim = c(2008, 2011), ylim = c(1, 2.5), axes=TRUE,
          inset_xlim = c(2001, 2008), inset_ylim = c(6, 12))

ggm
ggsave("output/gdp_growth_day30.png", ggm, bg="white", width=725, height=561, units="px", dpi=72) 
