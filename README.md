# Project 2 — Multiple Linear Regression (Insurance Dataset)

## 📌 Project Goal
Examine how multiple predictors (**age, BMI, sex, children, smoker status, region**) jointly affect **insurance charges**, and compare the performance of a simple vs multiple regression model.

## 📊 Dataset
- Source: `insurance.csv`  
- Variables:  
  - `charges` (Insurance charges in USD)  
  - `age` (Age in years)  
  - `bmi` (Body Mass Index)  
  - `sex` (Male / Female)  
  - `children` (Number of children covered by insurance)  
  - `smoker` (Yes / No)  
  - `region` (Geographic region)  

## 🧪 Analysis Overview
- Data quality checks (`glimpse`, `summary`, missing values)  
- Convert categorical variables to factors (`sex`, `smoker`, `region`)  
- Exploratory Data Analysis (EDA):  
  - Summary statistics by smoker status  
  - Distribution of charges  
  - Charges by smoker (boxplot)  
  - Age vs charges by smoker  
  - BMI vs charges by smoker  
- Correlation matrix and correlation plot  
- Fit models:  
  - Simple linear regression: `charges ~ age`  
  - Multiple linear regression: `charges ~ age + bmi + sex + children + smoker + region`  
- Model comparison (R², ANOVA, AIC, BIC)  
- Diagnostic checks:  
  - Residuals vs fitted  
  - Normal Q-Q  
  - Scale-location  
  - Cook’s distance  
- Multicollinearity check using VIF  
- Coefficients with 95% confidence intervals  

## 📈 Key Findings
- The multiple regression model explains **~75% of the variance** in insurance charges (R² ≈ 0.75), compared to **~9%** for the simple age-only model.  
- **Smoking status** is the strongest predictor: smokers pay approximately **$23,800 more** than non-smokers, holding other variables constant.  
- **Age** and **BMI** have significant positive effects on charges.  
- ANOVA confirms the full model is significantly better than the simple model (p < 0.001).  
- AIC and BIC are substantially lower for the multiple model, supporting its superiority.  

## 🧠 Model Diagnostics
- Residuals show generally acceptable patterns with **mild heteroscedasticity** at higher fitted values.  
- Residuals are approximately normal with slight tail deviations.  
- No influential points strongly affecting the model (Cook’s distance).  
- All VIF values are < 5 → **no multicollinearity concerns**.  

## 🖼️ Visualization
Key visualizations include:  
- Distribution of insurance charges  
- Charges by smoker status (boxplot)  
- Age vs charges by smoker  
- BMI vs charges by smoker  
- Diagnostic plots for multiple regression  

> (Add your plot paths here, e.g. `plots/charges_by_smoker.png`)

## 🧠 Conclusion
The multiple linear regression model provides a strong explanatory framework for insurance charges, with smoking status, age, and BMI emerging as the most influential predictors.  
The model performs substantially better than a simple age-only model and satisfies regression assumptions reasonably well, despite mild heteroscedasticity and skewness typical of real-world insurance data.  

These findings align with medical and actuarial expectations and provide a solid foundation for further modeling, including interaction effects (e.g., BMI × smoker) and non-linear extensions.

> Note: This project is intended for **learning and methodological practice**, not for causal or clinical inference.
