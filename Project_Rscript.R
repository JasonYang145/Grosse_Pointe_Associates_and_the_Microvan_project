# Load data
mic_data <- read.csv("microvan.csv")
head(mic_data)

#Checking Null values
is.na(mic_data)
sum(is.na(mic_data))
# No NULL Value

# Finding Correlation between Variables
install.packages("corrplot")
source("http://www.sthda.com/upload/rquery_cormat.r")
rquery.cormat(mic_data[,3:32], type="full")

#Checking distribution using histogram
hist(mic_data$mvliking)
hist(mic_data$passnimp)
hist(mic_data$kidtrans)
hist(mic_data$miniboxy)
###other variables have the similar distribution trends.
summary(mic_data)

##Initial Model
initial.model.data <- mic_data[,2:32]
initial.model <- lm(mvliking ~ ., data = initial.model.data)
summary(initial.model)

## Stepwise Model
install.packages("MASS")
library(MASS)
step.model <- stepAIC(initial.model, direction = "both", 
                      trace = FALSE)
summary(step.model)

# **FACTOR ANALYSIS

# Step 1: Evaluate the data
# run Bartlett's Test of Sphericity (want p < 0.05 to go ahead)
#install.packages("REdaS")
library("REdaS")
bart_spher(mic_data[,3:32])
###p < 0.05

# run KMO-test (want overall MSA > 0.6 to go ahead)
#install.packages("psych")
library("psych")
KMO(mic_data[,3:32])
###Overall MSA > 0.6

# Step 2: Determine the number of factors
# install package for Factor Analysis
#install.packages("FactoMineR")
library("FactoMineR")
pca <- PCA(mic_data[,3:32], scale = TRUE)
summary(pca)
#eigenvalues
pca$eig

# visualize eigenvalues / screeplot
#install.packages("factoextra")
library("factoextra")
fviz_eig(pca)
##Since the first 5 factors could explain more than 70% of the variables, we choose these five as our factors.

##Hierarchical Clustering using ward method to determine the number of factors we use
# create a dissimilarity matrix
d <- dist(mic_data[,3:32], method = "euclidean")

# perform hierarchical clustering using Ward's method on this matrix
hc <- hclust(d, method="ward.D") 

# plot the resulting dendrogram
plot(hc, cex = 0.6, hang = -1)

# Step 3: Extract the factor solution (varimax rotation)
fit <- factanal(mic_data[,3:32], factors=5, rotation="varimax")

# loadings
fit$loadings
as.table(fit$loadings)


# loadingplot
load1 <- fit$loadings[,1:2]
plot(load1, main = "Factor loadings", xlab = "Factor 1", 
     ylab = "Factor 2", col="blue", bg = "blue", pch=21)
text(load1,labels=names(mic_data),adj = c(0,0))
abline(h=0, v=0, col="purple")

load2 <- fit$loadings[,2:3]
plot(load2, main = "Factor loadings", xlab = "Factor 2", 
     ylab = "Factor 3", col="blue", bg = "blue", pch=21)
text(load2,labels=names(mic_data),adj = c(1,1))
abline(h=0, v=0, col="purple")

load3 <- fit$loadings[,3:4]
plot(load3, main = "Factor loadings", xlab = "Factor 3", 
     ylab = "Factor 4", col="blue", bg = "blue", pch=21)
text(load3,labels=names(mic_data),adj = c(.5,1))
abline(h=0, v=0, col="purple")

load4 <- fit$loadings[,4:5]
plot(load4, main = "Factor loadings", xlab = "Factor 4", 
     ylab = "Factor 5", col="blue", bg = "blue", pch=21)
text(load4,labels=names(mic_data),adj = c(.5,1))
abline(h=0, v=0, col="purple")


# Step 4: Create and name the factor scores
scores <- factor.scores(mic_data[,3:32], fit$loadings)$scores
mic_data$premium_quality <- scores[,1]
mic_data$Capacity_Seating <- scores[,2]
mic_data$safe_family <- scores[,3]
mic_data$environment <- scores[,4]
mic_data$durability_safety <- scores[,5]
View(mic_data)

##Factor Model
factor.model <- lm(mvliking ~ premium_quality + Capacity_Seating + safe_family + environment + durability_safety, data = mic_data)
summary(factor.model)
AIC(initial.model)
BIC(initial.model)
AIC(factor.model)
BIC(factor.model)

# **CLUSTER ANALYSIS

# Step 1: determine the number of clusters
# create a dissimilarity matrix
d <- dist(mic_data[,40:44], method = "euclidean")

# perform hierarchical clustering using Ward's method on this matrix
hc <- hclust(d, method="ward.D") 

# plot the resulting dendrogram
plot(hc, cex = 0.6, hang = -1)


# Step 2: Calculate the final cluster solution
# note that K-Means uses a random seed; if you want to see the same 
# result you got before, use the same seed
set.seed(42)

# run K-Means to find 3 clusters
kmeans.solution <- kmeans(mic_data[,40:44], centers = 3)

# create new variable showing who is in which clusteråååA
mic_data$cluster <- kmeans.solution$cluster
View(mic_data)


# Step 3: Interpret the K-means output
# look at the cluster centers to distinguish each cluster
# (we want to look for high & low values)
kmeans.solution$centers

# visualize K-means clusters
fviz_cluster(kmeans.solution, data=mic_data[,40:44])

library(scatterplot3d)
scatterplot3d(mic_data[,40:42], pch=20, color=rainbow(3)[kmeans.solution$cluster])
scatterplot3d(mic_data[,41:43], pch=20, color=rainbow(3)[kmeans.solution$cluster])

## Calculate WSS


# name the clusters
# Cluster 1: "Quality racing enthusiasts"    (high on quality, low on volume)
# Cluster 2: "Economical and applicable"   (low on quality)
# Cluster 3: "Wealthy large families"  (high on quality and volume)

###We tried different cluster numbers and all of them had overlapping...

# Step 4: Add labels to the clusters
library(plyr)
mic_data$segment.label <- revalue(as.character(mic_data$cluster),
                                    c("1"="QualityRacing", "2"="Economical", "3"="WealthyLargeFam"))
View(mic_data)

# **EXPLORING THE CLUSTERS

# Step 1: Regression of mvliking on the cluster id categorical variable

cluster1.model <- lm(mvliking ~ factor(segment.label), data = mic_data)
summary(cluster1.model)
cluster2.model <- lm(mvliking ~ relevel(factor(segment.label), ref = "QualityRacing"), data = mic_data)
summary(cluster2.model)

##The results show that wealthy large families have the most significant positive effect on mvliking.

# Step 2: t-tests of the mean of mvliking for the different clusters
mean.mic.data <- mean(mic_data$mvliking)
mean.mic.data

subset.data <- split(mic_data, mic_data$cluster)
quality.racing <-subset.data$`1`
economical <- subset.data$`2`
wealthy.large.fam <- subset.data$`3`

mean.quality.racing <- mean(quality.racing$mvliking)
mean.quality.racing
mean.economical <- mean(economical$mvliking)
mean.economical
mean.wealthy.largefam <- mean(wealthy.large.fam$mvliking)
mean.wealthy.largefam 

t.test(quality.racing$mvliking, mu = mean.mic.data, alternative = "greater")
t.test(economical$mvliking, mu = mean.mic.data, alternative = "greater")
t.test(wealthy.large.fam$mvliking, mu = mean.mic.data, alternative = "greater")

# t-test got the same result that wealthy.large.fam has the mean value of mvliking 
#which is significantly greater than the mean of the whole sample.

# Step 3: Cross tabulation and chi-squared analysis

# run simple tabulation (segment.label)
tab <- table(mic_data$segment.label) # frequency
tab <- cbind(tab, prop.table(tab)) # proportion
sum <- colSums(tab); tab <- rbind(tab, sum) # sum
colnames(tab) <- c("frequency", "proportion")

# print result
print(tab, digits=4)

# CROSSTABS
# run cross tabulation (mvliking & segment.label)
crosstab <- xtabs(~mvliking+segment.label, mic_data)
crosstab

# show overall chi-squared analysis
summary(crosstab)

# use package to run cross tabulation (mvliking & segment.label)
#install.packages("gmodels")
library(gmodels)
CrossTable(mic_data$mvliking, mic_data$segment.label, expected=TRUE) 

# the results proof that wealthy large families are our target group.

# **DEMOGRAPHICS

# Step1 Classify age, income, and miles to convert them into categorical data
summary(mic_data[,33:35])
mic_data$age_group <- cut(mic_data$age,
                       breaks=c(18, 34, 46, 61),
                       labels=c('young', 'middle', 'old'))
mic_data$income_group <- cut(mic_data$income,
                          breaks=c(14, 36, 96, 274),
                          labels=c('low', 'medium', 'high'))
mic_data$miles_group <- cut(mic_data$miles,
                             breaks=c(6, 15, 21, 33),
                             labels=c('low', 'medium', 'high'))
summary(mic_data[,47:49])

# Step2 Cross tabulation and chi-squared analysis

# CROSSTABS
# run cross tabulation (age_group & segment.label)
crosstab_age <- xtabs(~age_group+segment.label, mic_data)
crosstab_age
crosstab_income <- xtabs(~income_group+segment.label, mic_data)
crosstab_income
crosstab_miles <- xtabs(~miles_group+segment.label, mic_data)
crosstab_miles
crosstab_numkids <- xtabs(~numkids+segment.label, mic_data)
crosstab_numkids
crosstab_gender <- xtabs(~female+segment.label, mic_data)
crosstab_gender
crosstab_educ <- xtabs(~educ+segment.label, mic_data)
crosstab_educ
crosstab_recycle <- xtabs(~recycle+segment.label, mic_data)
crosstab_recycle
# show overall chi-squared analysis
summary(crosstab_age)
summary(crosstab_income)
summary(crosstab_miles)
summary(crosstab_numkids)
summary(crosstab_gender)
summary(crosstab_educ)
summary(crosstab_recycle)
# use package to run cross tabulation (demographics & segment.label)
#install.packages("gmodels")
library(gmodels)
CrossTable(mic_data$age_group, mic_data$segment.label, expected=TRUE)
CrossTable(mic_data$income_group, mic_data$segment.label, expected=TRUE) 
CrossTable(mic_data$miles_group, mic_data$segment.label, expected=TRUE) 
CrossTable(mic_data$numkids, mic_data$segment.label, expected=TRUE) 
CrossTable(mic_data$female, mic_data$segment.label, expected=TRUE) 
CrossTable(mic_data$educ, mic_data$segment.label, expected=TRUE) 
CrossTable(mic_data$recycle, mic_data$segment.label, expected=TRUE) 

# According to the results of cross tabulation, we found that 
#The demographics data of different clusters makes sense on the whole.
#Most of the people in wealthylargefamilies are middle-aged, middle income or above, 
#high mileage, at least 2 children and higher education. 
#This fits the profile of a member of a large, wealthy family. 
#The majority of qualityracing's people are middle-aged and above, with moderate income and above, 
#moderate mileage, two children at most and advanced education. 
#Economical people tend to be young, low-income, have at most one child, and have secondary education.

