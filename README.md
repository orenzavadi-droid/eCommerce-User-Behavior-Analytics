🛒 eCommerce User Behavior & Conversion Analytics
💼 Business Case & Objective
An e-commerce multi-category platform experienced a noticeable drop in overall conversion rates and a decline in customer metrics over recent quarters. Despite high traffic volumes, user engagement within the shopping funnel was suboptimal, leading to lost revenue opportunities.

The objective of this project is to analyze raw, large-scale clickstream data (42+ million rows) to map the user journey, diagnose behavioral friction points (specifically cart abandonment), and deliver data-driven, actionable recommendations to product and UX teams using an interactive executive dashboard.

📊 About the Dataset
Source: REES46 eCommerce behavior data (Multi-Category Store Dataset).

Scale: Real-world clickstream data capturing over 42,448,764 user events (view, cart, purchase).

Key Attributes Analyzed: event_time, event_type, product_id, category_id, price, user_id, and user_session.

🛠️ Tech Stack & Methodology
SQLite (Data Agility Pivot): Utilized for local architecture, quick data ingestion via command-line piping, and high-performance querying on 42M+ rows directly inside the local workspace.

SQL: Used for heavy lifting, user-flow segmentation, conditional aggregations, and calculating funnel conversion metrics.

Tableau: Used to develop an interactive, stakeholder-facing executive dashboard tracking core product KPIs, funnel behaviors, and revenue leakages.

🔍 Key Analytical Steps & Scripts
1. Data Ingestion & Architectural Pivot (Technical Retro)
The Challenge: Initial attempts to ingest the 42M-row dataset into a local MySQL server hit critical friction points, including database timeouts, UTC timestamp parsing issues, and local directory security restrictions (secure-file-priv blocks).

The Resolution: Switched to SQLite using DB Browser for SQLite. Leveraging native system data-piping mechanisms, the full 42M rows were ingested into a single, light, serverless .db file within minutes, establishing an agile and portable local repository pipeline.

2. Funnel Architecture & Anomaly Resolution (SQL)
Script Location: /SQL_Scripts/1_conversion_funnel_fixed.sql

Objective: Computed unique users at each stage (view ➔ cart ➔ purchase) to locate user drop-offs.

The Discovery & Deep Dive: A standard linear funnel query produced a flawed 110.6% Cart-to-Purchase conversion rate (more buyers than cart additions). A secondary user-level segmentation script isolated the root cause: 48.1% of successful buyers bypassed the cart stage entirely (37,893 out of 78,674 total buyers), proving the massive dominance of an Express Checkout / "Buy Now" button.

Corrected Baseline KPIs (Week 1 Representative Sample):

Total Unique Users Analyzed: 851,711

View-to-Cart Engagement Rate: 8.35%

Overall Site Conversion Rate (View-to-Purchase): 9.24%

3. High-Risk Cart Abandonment Diagnostic (SQL)
Script Location: /SQL_Scripts/2_cart_abandonment.sql

Objective: Analyzed user sessions at a granular product and category level to isolate instances where a user added an item to a cart but exited without completing a purchase, filtering for high-activity segments (HAVING additions > 10).

Key Category Matrix Findings:

"High-Stakes Friction" (Category ...0549 & ...3671): High-ticket categories ($356.20 - $524.03 avg price) exhibit a steep 77.78% abandonment rate. Shoppers demonstrate high intent but experience severe "Sticker Shock" at checkout, presenting the site's biggest raw revenue recovery opportunity.

"Impulsive Browsing & Shipping Shock" (Category ...7671): Low-cost items ($24.84 avg price) drive the highest volume of interactions (137 cart additions), but suffer a massive 77.37% abandonment rate (106 drop-offs), indicating transaction drop-offs likely triggered by shipping/handling fees added at checkout.

"Severe Roadblock" (Category ...0485): Suffered the worst performance in the dataset with an 85.71% abandonment rate on mid-to-high tier products ($146.27 avg price), indicating potential page errors or high competitive friction.

📈 Executive Dashboard (Tableau)
The results of this analysis were translated into an interactive executive dashboard designed for product managers and stakeholders.

Monitored Product KPIs: Conversion Rate (CR), Average Order Value (AOV), Cart Abandonment Rate (CAR), and Category Leakage.

🔗 [Click Here to View the Live Tableau Dashboard] (Insert your Tableau Public link here later)

💡 Behavioral Insights & Actionable Recommendations
Based on the data analysis, the following structural product/UX interventions are recommended:

Redefine Dashboard Funnel Architecture: Product management teams must immediately separate linear and express checkout pipelines in BI systems to stop conversion rate inflation and track true feature ROI reliably.

Automated Retargeting Triggers for High-Ticket B2C: Implement an automated, behavior-triggered cart-abandonment email system timed exactly 30 minutes post-exit for products over $300 (Categories ...0549 / ...3671). Incorporating warranty info or a limited 5% incentive will ease checkout anxiety.

Overcome Shipping Friction on Impulse Items: For high-volume, low-cost categories like ...7671, deploy dynamic checkout banner alerts (e.g., "Add just $15 more to unlock Free Shipping!") to convert impulse cart additions into completed transactions before shipping fees cause drop-offs.

