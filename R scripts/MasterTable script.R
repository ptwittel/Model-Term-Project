masterTable_raw <- read_csv("Data Clean/master_table.csv")


masterTable <- masterTable_raw %>% 
  rename(plastic_waste_gen = `Plastic waste generation (tonnes, total)`,
         plastic_waste_per_cap = `Per capita plastic waste (kg/person/day)`,
         mismanaged_waste = `Mismanaged waste (% global total)`,
         percent_of_inadequate_managed = `Share of plastic inadequately managed`,
         GDP = `GDP (in USD 2015)`) 

masterTable <- masterTable%>% 
  mutate(GDP_per_cap = masterTable$`GDP`/ Population_2010)


## Random Forest Imputation
masterTable_rf <- masterTable %>% select(-Code) %>% 
                        mice::mice(., 
                           m =5, 
                           method = "rf",
                           seed = 971)

masterTable_rf_complete <- complete(masterTable_rf)

write_csv(masterTable_rf_complete, "Data Clean/MT_imp_rf.csv")

## Cart Imputation
masterTable_cart <- masterTable %>% select(-Code) %>% 
  mice::mice(., 
             m =5, 
             method = "cart",
             seed = 971)

masterTable_cart_complete <- complete(masterTable_cart)

write_csv(masterTable_cart_complete, "Data Clean/MT_imp_cart.csv")