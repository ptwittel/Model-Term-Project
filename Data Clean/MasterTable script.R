masterTable <- read_csv("Data Clean/master_table.csv")

MT_gdpPop <- masterTable %>% 
  mutate("Per capita GDP (in USD 2015)" = masterTable$`GPD (in USD 2015)`/ Population_2010)

MT_gdpPop %>% filter(is.na(Population_2010) == 0) %>% 
  pull(Entity) %>% 
  str_detect("Island") %>% 
  mean()


