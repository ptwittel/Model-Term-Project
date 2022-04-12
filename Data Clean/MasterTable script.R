masterTable <- read_csv("Data Clean/master_table.csv")

masterTable_simpName <- MT_gdpPop %>% 
  rename(plastic_waste_gen = `Plastic waste generation (tonnes, total)`,
         plastic_waste_per_cap = `Per capita plastic waste (kg/person/day)`,
         mismanaged_waste = `Mismanaged waste (% global total)`,
         percent_of_inadequate_managed = `Share of plastic inadequately managed`,
         GDP = `GDP (in USD 2015)`)

MT_gdpPop <- masterTable_simpName %>% 
  mutate(GDP_per_cap = masterTable$`GDP (in USD 2015)`/ Population_2010)


MT_impute <- MT_gdpPop %>% select(-Code) %>% 
                        mice::mice(., 
                           m =5, 
                           method = "rf",
                           seed = 971)


