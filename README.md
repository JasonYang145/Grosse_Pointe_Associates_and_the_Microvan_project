# Grosse_Pointe_Associates_and_the_Microvan_project

Marketing Intelligence Project Report: Grosse Pointe Associates and the ‘Microvan’

Original Analysis Report: https://medium.com/@zy145/marketing-intelligence-project-report-grosse-pointe-associates-and-the-microvan-b77cc7cdb71b

![image](https://user-images.githubusercontent.com/98763622/162602046-dc35363a-b067-41cb-bb4a-5a8b0bdaeef0.png)


## Table of contents
* [Introduction](#Introduction)
* [Initial Model](#Initial_Model)
* [Factor Analysis](#Factor_Analysis)
* [Factor Model](#Factor_Model)
* [Clustering Analysis](#Clustering_Analysis)
* [Exploring the Clusters](#Exploring_the_Clusters)
* [Demographics Analysis](#Demographics_Analysis)
* [Business Action Recommendation](#Business_Action_Recommendation)

## Introduction

Through this project, we tried to deep dive into the automotive market to see what factors affect consumers’ buying decisions. Given the survey data collected by Grosse Pointe Associates (GPA), we explored the dataset, analyzed the automobile attributes, and survey responders’ psychographic factors that lead us to segment the market and identify our target customer base.
	
![image](https://user-images.githubusercontent.com/98763622/162602114-4ea7607d-f35b-469f-a1ec-88a28eedb253.png)

![image](https://user-images.githubusercontent.com/98763622/162602120-13ef826b-4223-44c0-93af-e13abcb6d7d2.png)

## Initial_Model

Before building the initial model, we explored the dataset for better data understanding. First starting from checking that there is no null value, we then examined the correlation between variables. By making a correlation matrix visualization (Figure 1), one could find that certain dependent variables have a strong correlation with each other.

![image](https://user-images.githubusercontent.com/98763622/162602141-b4dfc79d-6dbb-4386-bb01-5dd69d58f576.png)

After that, we delved into the distribution of variables by composing the histograms and checking the summary data. Dependent variables have similar normal distribution trends (Figure 2) while the independent variable mvliking has a different shape of the distribution (Figure 3).

![image](https://user-images.githubusercontent.com/98763622/162602150-43dbb3b1-1ff1-489f-8818-11af5a7b1c53.png)

![image](https://user-images.githubusercontent.com/98763622/162602155-44247d4c-8283-4155-aac9-0c922bc94217.png)

Next, we regressed the target variable against all the attribute variables. There are eight variables with p-value around 0.05 and among those eight variables, lthrbetr and shdcarpl show statistically significance as their p-value are lower than 0.05. As have so many variables and strong correlation within the predictors, we feel the need to do the factor analysis to reduce the redundancy of our attribute variables.
	
## Factor_Analysis

* Run Bartlett’s Test of Sphericity and KMO-test

![image](https://user-images.githubusercontent.com/98763622/162602183-022e2c93-c386-4868-9741-752f89b0f3af.png)

Here we set the null hypothesis that the correlation matrix is an identity matrix; in other words, the null hypothesis suggests that the variables are unrelated and not ideal for factor analysis. After running Bartlett’s Test with a p-value < 2.22e-16, we reject the null hypothesis. The result is statistically significant, and it suggests that the correlation matrix can be used to do the factor analysis.
The KMO-test is used to examine how the factors explain each other. KMO values closer to 1.0 are considered ideal, while values less than 0.5 are unacceptable. As we can see in Figure 4, most variables have KMO values greater than 0.9, and all the variables are considered good enough for factor analysis.

* Determine the number of factors

We use two approaches to determine how many factors explain as much variance in the data. First, the variables with eigenvalues less than 1 suggest that factors do not explain even as much variance in the data as an ‘average’ variable. As we can see in Figure 5, only the first five components have eigenvalues greater than 1. The same result can be discovered from the Scree-plot (Figure 5); the ‘elbow’ is visible in the curve; it suggests that 5 is the right number of clusters.

![image](https://user-images.githubusercontent.com/98763622/162602205-272ae505-8df5-4354-8335-031ee5632a4e.png)

![image](https://user-images.githubusercontent.com/98763622/162602208-97b81a34-2aab-434b-a8c5-bbce85816baf.png)

* Extract the factor solution (varimax rotation)

The varimax rotation enables us to extract and rotate factors to generate a solution. The outputs include the loading plots and the rotated component matric, which help reveal the meaning of the underlying factors. However, as we can see from the loading plot (Figure 7), the variables overlap, making it much harder to interpret based on it.

![image](https://user-images.githubusercontent.com/98763622/162602217-b307276b-2c39-4309-8ec4-96589faf371f.png)

Therefore, we analyze the Loading tables(Figure 8) to identify the underlying factors and determine their meanings.

![image](https://user-images.githubusercontent.com/98763622/162602221-e1c48351-8e09-4e30-a444-f714c6b657d7.png)

After considering the positive and negative correlations, we decided to name these five factors: quality matters, the volume of the car, family car, environmentally aware, and safety concerns.

Premium Quality: Consumers in this factor group care about the quality of cars. The positively correlated variables suggest that consumers prefer to spend more on their car purchases; they care about the cars’ product quality and features — leather seats, car accessories & premium sound systems.

Capacity: Consumers in this group care about the no. of seats in the car. They want mid-segment, affordable utility vehicle

Affordability & Safety (Good Quality Material Used in the car): Consumers in this segment are families which use their cars a lot to drive around their children

Environmentally Friendly: This factor group consists of people who take environmental factors into account when purchasing cars. They prefer a car with environmentally friendly features and prefer carpools

Durability & Safety (Driver Protection i.e., Airbags): This factor group consists of people who put safety as their priority concern when purchasing cars. Variables such as ‘Auto safety is very important to me,’ and ‘Four-wheel drive is a very attractive option’ explain a lot about this group of consumers.

* Create and save the factor scores

During the last step, we created names for these five factors (quality, volume, capacity, environment, and safety) based on the analysis above, and then saved the factor scores for further use.

## Factor_Model

We discovered the new regression model (with the saved factor score as the independent variable — Figure 11). Firstly, the factor model is statistically significant with a p-value less than 0.05. Secondly, the quality, the volume, and the safety variables are significant, with p- values less than 0.05. However, the capacity and the environment variables have slightly larger p-values (0.0589, 0.1181 respectively) which means they are statistically insignificant here. Moreover, the quality’s positive coefficient has suggested that as the quality of the car increases; consumers’ attitudes toward the new concept of the car go up, and it seems to be the most impactful factor. Thirdly, we use AIC and BIC in model selections, and it suggests that the Factor model is a better model than the initial one since the factor model have lower AIC and BIC compared with the initial model (Figure 9). Lastly, the adjusted R^2 is slightly higher for Factor Model than the Initial Model (Figure 10), which means the variables in Factor Model can explain the model better than the variables in Initial Model.

![image](https://user-images.githubusercontent.com/98763622/162602310-65e62bd0-f05f-420a-b178-b973be605d41.png)

## Clustering_Analysis

Based on the five factors we defined, we started a cluster analysis of the data to find our target group. Firstly, to determine the number of our clusters, we first applied hierarchical clustering using Ward’s method to conduct preliminary clustering of our data. The result of clustering is shown in Figure 12.

![image](https://user-images.githubusercontent.com/98763622/162602375-f81d7908-2a99-49de-89c9-1b8cf3d76246.png)

Based on the results, we set our number of clusters to 3. Then we used the k-means clustering method to cluster our data. The clustering results are shown in the following table. (Figure 13)

![image](https://user-images.githubusercontent.com/98763622/162602382-665192fa-a281-4698-8a02-9f8500927632.png)

To more clearly observe whether the K-means clustering method well separated the data into three groups, we used 3D scatter graph to visualize our results. The visualization results are as follows. (Figures 14 and 15)

![image](https://user-images.githubusercontent.com/98763622/162602389-2ac436bc-12ee-4519-839d-49378f916bd0.png)

![image](https://user-images.githubusercontent.com/98763622/162602393-7abaa749-c325-45ce-a959-4062e37c4f46.png)

As can be seen from the results, although some data overlapped, we divided the data into three groups with differences overall. According to the results of the center of each group shown by k-means clustering, we can well summarize the characteristics of these three groups. Cluster 1 cares about the quality of life. They don’t go for big cars. Instead, they prefer small cars like 2-seaters cars or racing cars. They don’t care much about car capacity, durability, environmental protection, and safety. Cluster 2, they are very concerned about economic expenditure. They usually don’t care about the capacity of the car. They don’t have a strong sense of environmental awareness. Cluster 3 has a high pursuit of life quality. They like larger vehicles the size of which is better between microvan and sedan. They need a vehicle that can accommodate more people like a group of family members safely. They relatively care more about environmental protection and durability and safety of the car compared with the other two segments. Therefore, we define our three clusters as Cluster 1 — Quality Racing Enthusiasts, Cluster 2 — Economical and Applicable, Cluster 3 — Wealthy Large Families. (Table 1)

![image](https://user-images.githubusercontent.com/98763622/162602406-e1eece43-b471-4ed9-8a0c-d2908a848dec.png)

![image](https://user-images.githubusercontent.com/98763622/162602410-2b32c4c2-3e15-4c45-a74e-78d74dae711a.png)

## Exploring_the_Clusters

To determine how the clusters vary on the concept liking, we tried three different methods.

First, we conducted the regression of mvliking on the cluster categorical variable. As it is categorical data, we are bound to lose the explanation of one cluster in the regression process. To this end, we changed the categories’ order to carry out two regressions to the model. The result of the regression is as follows. (Figures 16 and 17)

![image](https://user-images.githubusercontent.com/98763622/162602435-0bd2fd0d-7275-4e53-9bda-cb1c1ede17d3.png)

![image](https://user-images.githubusercontent.com/98763622/162602436-0f80dc2b-4389-4f16-a0c8-a46d138e57f0.png)

According to the regression results, only wealthy large families cluster has a significant positive impact on the attitude towards the new concept of the car. Quality racing has a positive but insignificant impact on attitude. Economical and applicable not only has a negative impact on our attitudes toward the new concept but also are not significant. This means that wealthy large families are very likely to be our target group.

To further verify our conclusion, we conducted a T-test on the mean values of different clusters’ attitudes to our new concept. Our hypothesis is that the average attitudes of the three clusters to the new concept is greater than the overall mean. Our results are shown in Figures 18, 19, and 20. It was proved that only the mean of wealthy large families passed the T-test. This validates what we learned in the first step.

Finally, we did cross-tabulation and Chi-Squared analysis of segment label and MVliking to further verify our conclusion. The results of the analysis are in Figure 21 ( See appendix for detailed results of analysis).

![image](https://user-images.githubusercontent.com/98763622/162602452-a02e5c03-f81a-4968-9f54-cda80dcda3b2.png)

As can be seen from the results, wealthy large families obviously have more positive attitudes and an upward trend than the two clusters of Economical and quality racing. And, overall, it passed the Chi-Squared test. Then we can conclude that our target group is wealthy large families.

## Demographics_Analysis

Finally, we analyzed the demographic characteristics of three different clusters to test whether our conclusion is in line with reality. To accomplish this step, cross Tabulation and Chi-Squared analyses were performed on the demographic data and clusters.

First, for the convenience of analysis, continuous variables (age, income, and miles) in demographics are transformed into categorical variables. We divided these three variables into three groups based on the minimum value, 1st quantile, 3rd quantile, and maximum value. The grouping results are as follows. (Figure 22)

![image](https://user-images.githubusercontent.com/98763622/162602461-77ff1f47-0bcf-4b1d-8ded-c72aaa0fa7cd.png)

Then we performed cross Tabulation and Chi-Squared analysis on cluster and each demographic variable respectively (Figures 23, 24, 25 and 26).

![image](https://user-images.githubusercontent.com/98763622/162602476-d4805c35-c9ba-401e-831a-76c53a72bff4.png)

![image](https://user-images.githubusercontent.com/98763622/162602486-67d96725-0b06-44d2-9eb9-f200b8177694.png)

![image](https://user-images.githubusercontent.com/98763622/162602491-66eb1d8f-62ca-45d0-80b0-75a486a536cd.png)

![image](https://user-images.githubusercontent.com/98763622/162602497-dc370215-ca19-41cc-82fc-3b97f4f9f8a3.png)

According to the results of Chi-Squared, except gender and recycle, all other variables have passed the test. By observing other variables, we summarized the following group characteristics for different clusters:

* Wealthy Large Families: most of them are middle-aged, have moderate income, drive high mileage, have at least two children and have received three or four levels of education.
* Quality Racing: Most of them are middle-aged or old-aged, with high income, moderate driving mileage, and only one child or so, and have received 3 levels of education.
* Economical and Applicable: The vast majority of them are young, have low incomes, drive low miles, have no children and have received second-grade education.

These demographic characteristics fit our definition of three clusters which means that our segmentation makes sense. Based on the above conclusions, we believe that our target group is wealthy large family members.

## Business_Action_Recommendation

Based on the different market segments we created, microvan is most likely to charm the educated large families. We highly recommend GPA target this segment that consists of middle-aged individuals, having moderate to high income with 2+ kids. This segment values quality, capacity, environment, and safety. GPA should position the microvan as an automobile that combines elite style with high functionality. We suggest they use multiple channels for marketing such as social media, prints, OTT or broadcast advertisements or even onboard mom influencers. These marketing techniques should depict families enjoying a weekend road trip with their kids, highlighting the stylish features of the car, enough room for the kids, their toys and baggage while keeping in mind kids' safety, and the long mileage run per gallon. As it is larger than a sedan but smaller than a minivan, the advertisements can position the microvan as the perfect compact van that can easily fit in the driveway.

![image](https://user-images.githubusercontent.com/98763622/162602521-bffbc5cc-714a-4274-b7ef-7b327b5c6a7d.png)

Additionally, we would recommend conducting a similar focus group survey to position microvans as commercial vehicles such as for logistics supply, airport cabs, school vans, etc. However, having the same vehicle for commercial use might lead to a smaller intent to purchase by the above-mentioned segment as the microvan might lose its charm as a stylish family automobile but conducting a survey could help us understand if there is a potential market in the logistics industry for similar vehicles and the manufacturer could plan to launch a modified model.

