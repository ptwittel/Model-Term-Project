tab8 <- read_csv("Data Clean/plastic_1.csv")

# NA EDA: Number of observations: 244
NA_table <- data.frame(
  "factor" = colnames(tab8%>% select(-Entity))[2:length(tab8)],
  
  sum_na = c(
  sum(is.na(tab8$`Plastic waste generation (tonnes, total)`)), #Number of NAs: 76; proportion missing: 0.3114754
  sum(is.na(tab8$Population)),                                 #Number of NAs: 17; proportion missing: 0.06967213
  sum(is.na(tab8$`Annual Growth Rate %`)),                     #Number of NAs: 18; proportion missing: 0.07377049 #US missing 
  sum(is.na(tab8$`Area (sq km)`)),                             #Number of NAs: 17; proportion missing: 0.06967213
  sum(is.na(tab8$`Density (per sq km)`)),                      #Number of NAs: 17; proportion missing: 0.06967213
  sum(is.na(tab8$`Total Fertility Rate`)),                     #Number of NAs: 18; proportion missing: 0.07377049
  sum(is.na(tab8$`Life Expectancy at Birth`)),                 #Number of NAs: 18; proportion missing: 0.07377049
  sum(is.na(tab8$`Under-5 Mortality Rate`)),                   #Number of NAs: 18; proportion missing: 0.07377049
  sum(is.na(tab8$`Per capita plastic waste (kg/person/day)`)), #Number of NAs: 58; proportion missing: 0.2377049
  sum(is.na(tab8$`Mismanaged waste (% global total)`)),        #Number of NAs: 58; proportion missing: 0.2377049
  sum(is.na(tab8$`Share of plastic inadequately managed`)),    #Number of NAs: 58; proportion missing: 0.2377049
  sum(is.na(tab8$gdp_per_capita))                             #Number of NAs: 48; proportion missing: 0.1967213
   )
)

NA_table <- NA_table %>% 
  mutate(prop = sum_na / nrow(tab8))

write_csv(NA_table, "Data Clean/NA_table.csv")
