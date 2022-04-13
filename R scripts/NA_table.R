# NA EDA: Number of observations: 244
NA_table <- data.frame(
  "factor" = colnames(tab7%>% select(-Code, -Year, -Entity))[2:10],
  
  sum_na = c(
  sum(is.na(tab7$`Plastic waste generation (tonnes, total)`)), #Number of NAs: 76; proportion missing: 0.3114754
  sum(is.na(tab7$Population)),                                 #Number of NAs: 17; proportion missing: 0.06967213
  sum(is.na(tab7$`Annual Growth Rate %`)),                     #Number of NAs: 18; proportion missing: 0.07377049 #US missing 
  sum(is.na(tab7$`Area (sq km)`)),                             #Number of NAs: 17; proportion missing: 0.06967213
  sum(is.na(tab7$`Density (per sq km)`)),                      #Number of NAs: 17; proportion missing: 0.06967213
  sum(is.na(tab7$`Per capita plastic waste (kg/person/day)`)), #Number of NAs: 58; proportion missing: 0.2377049
  sum(is.na(tab7$`Mismanaged waste (% global total)`)),        #Number of NAs: 58; proportion missing: 0.2377049
  sum(is.na(tab7$`Share of plastic inadequately managed`)),    #Number of NAs: 58; proportion missing: 0.2377049
  sum(is.na(tab7$gdp_per_capita))                             #Number of NAs: 48; proportion missing: 0.1967213
   )
)

NA_table <- NA_table %>% 
  mutate(prop = sum_na / nrow(tab7))

