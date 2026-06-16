# eCommerce-User-Behavior-Analytics

# 🛒 eCommerce User Behavior & Cohort Analytics

##  Business Case & Objective
An e-commerce multi-category platform experienced a noticeable drop in overall conversion rates and a decline in customer retention over recent quarters. Despite high traffic volumes, user engagement within the shopping funnel was suboptimal, leading to lost revenue opportunities.

The objective of this project is to analyze raw, large-scale clickstream data to map the user journey, identify behavioral friction points (specifically cart abandonment), perform cohort analysis to measure long-term user retention, and deliver data-driven, actionable recommendations to product and UX teams.

---

## 📊 About the Dataset
* **Source:** REES46 eCommerce behavior data (Multi-Category Store Dataset).
* **Scale:** Real-world clickstream data capturing millions of user events (`view`, `cart`, `purchase`).
* **Key Attributes Analyzed:** `event_time`, `event_type`, `product_id`, `category_id`, `price`, `user_id`, and `user_session`.

---

## 🛠️ Tech Stack & Methodology
* **SQL:** Used for heavy lifting, complex data querying, conditional aggregations, and calculating funnel conversion rates across large datasets.
* **R (tidyverse, ggplot2):** Utilized for advanced statistical analysis, behavioral segmentation, and building monthly cohort retention matrices.
* **Tableau:** Developed an interactive, stakeholder-facing dashboard tracking core product KPIs.

---

## 🔍 Key Analytical Steps & Scripts

### 1. Funnel Performance & Drop-off Analysis (SQL)
* **Script Location:** `/SQL_Scripts/1_funnel_analysis.sql`
* **Objective:** Computed unique users at each stage (`view` ➔ `cart` ➔ `purchase`) to pinpoint exactly where users drop off.
* **Key Finding:** *[Example: Discovered a critical 72% drop-off rate between adding an item to the cart and final purchase, indicating high checkout friction].*

### 2. High-Risk Cart Abandonment Tracking (SQL)
* **Script Location:** `/SQL_Scripts/2_cart_abandonment.sql`
* **Objective:** Isolated sessions where items were added to a cart but no purchase occurred within 24 hours, categorizing abandonment by product categories and price tiers.

### 3. User Cohort & Retention Analysis (R)
* **Script Location:** `/R_Scripts/cohort_retention.R`
* **Objective:** Grouped users into cohorts based on their first purchase month and tracked their repeat-purchase rate over a 6-month period.
* **Key Finding:** *[Example: Retention drops sharply by Month 2 (down to 12%), showing a clear gap in user re-engagement strategies].*

---

## 📈 Executive Dashboard (Tableau)
The results of this analysis were translated into an interactive executive dashboard. 
* **Monitored Product KPIs:** Conversion Rate (CR), Average Order Value (AOV), Cart Abandonment Rate (CAR), and Cohort Retention Performance.
* 🔗 **[Click Here to View the Live Tableau Dashboard]** *(Insert your Tableau Public link here later)*

---

## 💡 Behavioral Insights & Actionable Recommendations

Based on the data analysis, the following structural product/UX interventions are recommended:
1. **Optimize Checkout UX:** The high drop-off at the checkout phase suggests friction. Recommended to run Usability Testing (UT) on mobile checkout flows to identify input bottlenecks or hidden fees.
2. **Behavioral Retargeting Trigger:** Implement an automated, behavior-triggered push/email notification system targeting high-intent users within 2 hours of cart abandonment. 
3. **Price-Sensitive Retention Campaigns:** Data indicates that cohorts buying high-ticket items show the steepest decline in retention. Tailored loyalty programs or cross-selling strategies should be deployed during Month 2 to smooth the retention curve.
