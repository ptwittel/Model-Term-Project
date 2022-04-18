### This script creates a PCA graph of the data.

df <- read_csv("Data Clean/MT_imp_cart.csv")

df_pca <- prcomp(df[,2:length(df)], center = TRUE, scale. = TRUE)

pca.data <- data.frame(Entity = df$Entity,
                       X = df_pca$x[,1],
                       Y = df_pca$x[,2],
                       Z = df_pca$x[,3])

barplot(round(df_pca$sdev^2/sum(df_pca$sdev^2) * 100, 1),
        main =  "Scree Plot", xlab = "Principal Component", ylab = "Percent Variation")

ggplot(pca.data, aes(x = X, y = Y, color = Z)) +
  geom_point() +
  ggrepel::geom_text_repel( aes(label = Entity)) +
  xlab("PC - 1") +
  ylab("PC - 2") +
  title(main = "Principal Component Analysis")



# with just three principal components we can explain 70.1 of the variance

abs(df_pca$rotation[,1]) %>% 
  sort(., decreasing = TRUE)

abs(df_pca$rotation[,2]) %>% 
  sort(., decreasing = TRUE)

abs(df_pca$rotation[,3]) %>% 
  sort(., decreasing = TRUE)
