# --------------------------------------------------------
# Project: Medical Insurance Cost Prediction (Multiple Regression)
# Goal: Build a Multiple Linear Regression model to identify 
#       key predictors of insurance charges
#
# Author: Osman Omer Mustafa
# Date: February 2026
# --------------------------------------------------------

# 0) Load required libraries
# Load essential packages for data analysis, visualization, and regression
library(tidyverse)
library(broom)
library(ggfortify)
library(car)
library(corrplot)

# 1) Read data
# Read CSV data into a data frame
data <- read_csv("insurance.csv")

# 2) Basic checks
# Check the structure, summary statistics, and missing values
glimpse(data)
summary(data)
sum(is.na(data))

# 3) Ensure categorical variables are factors
# Convert categorical variables to factors for proper analysis
data <- data %>% 
  mutate(
    sex = as.factor(sex),
    smoker = as.factor(smoker),
    region = as.factor(region)
  )
# Check conversion 
glimpse(data)

# --------------------------------------------------------
# EXPLORATORY DATA ANALYSIS (EDA)
# --------------------------------------------------------

# 4) Summary statistics by smoker status
# Examine the mean, SD, and median of charges by smoker category
data %>% 
  group_by(smoker) %>% 
  summarise(
    n = n(),
    mean_charges = mean(charges),
    sd_charges = sd(charges),
    median_charges = median(charges)
  )

# 5) Correlation matrix for numeric variables
# Compute correlations between numeric variables
cor_matrix <- data %>% 
  select(age, bmi, children, charges) %>% 
  cor()
print(round(cor_matrix, 2))

# Plot the correlation matrix
corrplot(cor_matrix, method = "number", type = "upper")

# 6) Distribution of charges
# Visualize the distribution of the outcome variable
ggplot(data, aes(x = charges)) +
  geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7)

# 7) Charges by smoker status (boxplot)
# Visualize differences in charges between smokers and non-smokers
ggplot(data, aes(x = smoker, y = charges, fill = smoker)) +
  geom_boxplot() +
  labs(title = "Boxplot charges vs smoker")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(legend.position = "none")

# 8) Scatter plots: Age vs Charges (colored by smoker)
# Explore the relationship between age and charges with smoker status
ggplot(data, aes(x = age, y = charges, color = smoker)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE)+
  labs(title = "Age vs Charges by Smoker")+
  theme(plot.title = element_text(hjust = 0.5))

# 9) Scatter plots: BMI vs Charges (colored by smoker)
# Explore the relationship between BMI and charges with smoker status
ggplot(data, aes(x = bmi, y = charges, color = smoker)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE)+
  labs(title = "BMI vs Charges by Smoker")+
  theme(plot.title = element_text(hjust = 0.5))


# --------------------------------------------------------
# MODELS
# --------------------------------------------------------

# 10) Simple Linear Regression
# Fit a simple model using age as the predictor (baseline comparison)
model_simple <- lm(charges ~ age, data = data)

# 11) Multiple Linear Regression
# Fit a full model using all predictors
model_full <- lm(charges ~ age + bmi + sex + children + smoker + region, data = data)

# 12) Model summaries
# View detailed summary for simple and full models
tidy(model_simple)
tidy(model_full)

# 13) Model performance metrics
# Glance at overall model metrics
glance(model_simple)
glance(model_full)

# 14) Model comparison
# Compare simple vs full models using ANOVA, AIC, and BIC
anova(model_simple, model_full)
AIC(model_simple, model_full)
BIC(model_simple, model_full)

# --------------------------------------------------------
# DIAGNOSTIC PLOTS
# --------------------------------------------------------

# Create directories for plots and results if they don't exist
if (!dir.exists("plots")) dir.create("plots")
if (!dir.exists("results")) dir.create("results")

# 15) Residuals vs Fitted
# Check for linearity and homoscedasticity
p1 <- autoplot(model_full, which = 1)
p1
ggsave("plots/residuals_vs_fitted.png",)

# 16) Normal Q-Q
# Check for normality of residuals
p2 <- autoplot(model_full, which = 2)
p2
ggsave("plots/qq_plot_norm.png")

# 17) Scale-Location plot
# Check homoscedasticity (constant variance)
p3 <- autoplot(model_full, which = 3)
p3
ggsave("plots/scale_location.png")

# 18) Cook's Distance
# Identify influential points
p4 <- autoplot(model_full, which = 5)
p4
ggsave("plots/cooks_distance.png")

# --------------------------------------------------------
# MULTICOLLINEARITY CHECK
# --------------------------------------------------------

# 19) Variance Inflation Factor (VIF)
# Identify multicollinearity among predictors
vif_values <- vif(model_full)
vif_values


