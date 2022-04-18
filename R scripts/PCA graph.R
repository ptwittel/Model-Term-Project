### This script creates a PCA graph of the data.

df <- read_csv("Data Clean/MT_imp_cart.csv")

df_pca <- prcomp(df[,2:length(df)], center = TRUE, scale. = TRUE)

pca.data <- data.frame(Entity = df$Entity,
                       X = df_pca$x[,1],
                       Y = df_pca$x[,2])

ggplot(pca.data, aes(x = X, y = Y)) +
  geom_point()


barplot(round(df_pca$sdev^2/sum(df_pca$sdev^2) * 100, 1),
        main =  "Scree Plot", xlab = "Principal Component", ylab = "Percent Variation")

# with just three principal components we can explain 70.1 of the variance

abs(df_pca$rotation[,1]) %>% 
  sort(., decreasing = TRUE)

abs(df_pca$rotation[,2]) %>% 
  sort(., decreasing = TRUE)
