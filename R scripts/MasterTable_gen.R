masterTable <- read_csv("Data Clean/plastic_1.csv", 
                            col_types = cols(gdp_per_capita = col_number())) %>% 
  naniar::replace_with_na(replace = list(gdp_per_capita = "no data")) # some values labelled "no data"

names(masterTable) <- c("Entity", "waste_gen", "population", "growth_rate", "area", "density", "fert_rate", 
               "life_exp", "mort_rate", "per_cap_waste", "misman_waste", "share_misman", 
               "per_cap_gdp")


## Random Forest Imputation
masterTable_rf <- masterTable  %>% 
                        mice::mice(., 
                           m =31, 
                           method = "rf",
                           seed = 79069084)

masterTable_rf_complete <- complete(masterTable_rf)

write_csv(masterTable_rf_complete, "Data Clean/MT_imp_rf.csv")

## Cart Imputation
masterTable_cart <- masterTable  %>% 
  mice::mice(., 
             m =31, 
             method = "cart",
             seed = 79069084)

masterTable_cart_complete <- complete(masterTable_cart)

write_csv(masterTable_cart_complete, "Data Clean/MT_imp_cart.csv")

rm(masterTable, masterTable_rf_complete, masterTable_cart_complete)