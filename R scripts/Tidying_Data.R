#Script version of Tidying Data.Rmd

waste_total <- read_csv("Data Raw/plastic-waste-generation-total.csv")

waste_per_cap <- read_csv("Data Raw/plastic-waste-per-capita.csv")
waste_per_cap <-  waste_per_cap %>% 
  select(c("Entity", "Per capita plastic waste (kg/person/day)"))

waste_totgbl_mismanage <- read_csv("Data Raw/mismanaged-waste-global-total.csv")
waste_totgbl_mismanage <-  waste_totgbl_mismanage %>% 
  select(c("Entity", "Mismanaged waste (% global total)"))

waste_inadequate_manage <- read_csv("Data Raw/inadequately-managed-plastic.csv")
waste_inadequate_manage <-  waste_inadequate_manage %>% 
  select(c("Entity", "Share of plastic inadequately managed"))

pop <- read_csv("Data Raw/export.csv")
pop <- pop %>% 
  select(c("Country/Area Name", "Population", "Annual Growth Rate %", "Area (sq km)", 
           "Density (per sq km)", "Total Fertility Rate", "Life Expectancy at Birth", 
           "Under-5 Mortality Rate"))

country_gdp <- read_csv("Data Raw/Country-GPD-per-capita.csv")

country_gdp_capita <- country_gdp %>% transmute(Entity = country_gdp$`GDP per capita, current prices
 (U.S. dollars per capita)`,
                                                gdp_per_capita = `2010`)

gdp_per_cap <- country_gdp_capita[c(2:197),] #to ensure we have just the countries and not regions

tab1 <- full_join(waste_total, pop, by = c("Entity" = "Country/Area Name"))
tab2 <- full_join(tab1, waste_per_cap, by = c("Entity"))
tab3 <- full_join(tab2, waste_totgbl_mismanage, by = c("Entity"))
tab4 <- full_join(tab3, waste_inadequate_manage, by = c("Entity"))
tab5 <- full_join(tab4, gdp_per_cap, by = c("Entity"))
tab6 <- tab5

# Tidying up Entity names
tab6$Entity <- str_replace(tab6$Entity, ".*Bahamas.*", "Bahamas")
tab6$Entity <- str_replace(tab6$Entity, ".*Brunei.*", "Brunei")
tab6$Entity <- str_replace(tab6$Entity, "China, People's Republic of", "China")
tab6$Entity <- str_replace(tab6$Entity, "^Congo$", "Republic of Congo")
tab6$Entity <- str_replace(tab6$Entity, "Congo \\(Brazzaville\\)", "Republic of Congo")
tab6$Entity <- str_replace(tab6$Entity, "Congo, Republic of", "Republic of Congo")
tab6$Entity <- str_replace(tab6$Entity, "Congo \\(Kinshasa\\)", "Democratic Republic of Congo")
tab6$Entity <- str_replace(tab6$Entity, "Congo, Dem. Rep. of the", "Democratic Republic of Congo")
tab6$Entity <- str_replace(tab6$Entity, ".*C[ôo]te.*", "Cote d'Ivoire")
tab6$Entity <- str_replace(tab6$Entity, ".*Cura[cç]ao.*", "Curacao")
tab6$Entity <- str_replace(tab6$Entity, ".*Fa.?roe.*", "Faeroe Islands")
tab6$Entity <- str_replace(tab6$Entity, ".*Gambia.*", "The Gambia")
tab6$Entity <- str_replace(tab6$Entity, ".*Hong Kong.*", "Hong Kong")
tab6$Entity <- str_replace(tab6$Entity, "Korea, North", "North Korea")
tab6$Entity <- str_replace(tab6$Entity, "Korea, South", "South Korea")
tab6$Entity <- str_replace(tab6$Entity, "Korea, Republic of", "South Korea")
tab6$Entity <- str_replace(tab6$Entity, ".*Kyrgyz.*", "Kyrgyzstan")
tab6$Entity <- str_replace(tab6$Entity, ".*Lao.*", "Laos")
tab6$Entity <- str_replace(tab6$Entity, ".*Maca.*", "Macao")
tab6$Entity <- str_replace(tab6$Entity, ".*Micronesia.*", "Micronesia")
tab6$Entity <- str_replace(tab6$Entity, ".*Russia.*", "Russia")
tab6$Entity <- str_replace(tab6$Entity, ".*Saint Helena.*", "Saint Helena")
tab6$Entity <- str_replace(tab6$Entity, "São Tomé and Príncipe", "Sao Tome and Principe")
tab6$Entity <- str_replace(tab6$Entity, ".*Sint Maarten.*", "Sint Maarten")
tab6$Entity <- str_replace(tab6$Entity, ".*Slovak.*", "Slovakia")
tab6$Entity <- str_replace(tab6$Entity, ".*South Sudan.*", "South Sudan")  # South Sudan may need to be removed
tab6$Entity <- str_replace(tab6$Entity, ".*Taiwan.*", "Taiwan")
tab6$Entity <- str_replace(tab6$Entity, "Virgin Islands, British", "British Virgin Islands")


tab7 <- tab6 %>% 
  group_by(Entity) %>% 
  fill(everything(), .direction = "downup") %>% 
  slice(n=1)


tab8 <- select(tab7, -c("Code", "Year"))

rm(tab1, tab2, tab3, tab4, tab5, tab6, tab7, waste_inadequate_manage, waste_per_cap,
   waste_total, waste_totgbl_mismanage, pop, country_gdp, 
   country_gdp_capita, gdp_per_cap)

write_csv(tab8, "Data Clean/plastic_1.csv")

