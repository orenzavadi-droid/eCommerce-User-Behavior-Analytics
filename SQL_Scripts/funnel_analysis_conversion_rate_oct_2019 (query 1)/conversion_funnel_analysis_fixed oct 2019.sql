WITH funnel_stages AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS total_views,
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS total_carts,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_purchases
    FROM 
        ecommerce_events
    WHERE 
        event_time BETWEEN '2019-10-01' AND '2019-10-07'
)
SELECT 
    total_views,
    total_carts,
    total_purchases,
    ROUND((total_carts * 1.0 / total_views) * 100, 2) AS view_to_cart_rate,
    ROUND((total_purchases * 1.0 / total_carts) * 100, 2) AS cart_to_purchase_rate,
    ROUND((total_purchases * 1.0 / total_views) * 100, 2) AS overall_conversion_rate
FROM 
    funnel_stages;
	
	--LETS DEEP DIVE ! notice that the total carts < total purchases (it can have an explanation rather UX-UI or a defact in the data one needs to verify)
WITH user_behavior AS (
    SELECT 
        user_id,
        MAX(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS saw_product,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS added_to_cart,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS bought_product
    FROM 
        ecommerce_events
    WHERE 
        event_time BETWEEN '2019-10-01' AND '2019-10-07'
    GROUP BY 
        user_id
)
SELECT 
    COUNT(CASE WHEN added_to_cart = 1 AND bought_product = 1 THEN 1 END) AS standard_funnel_buyers,
    COUNT(CASE WHEN added_to_cart = 0 AND bought_product = 1 THEN 1 END) AS skipped_cart_buyers,
    COUNT(CASE WHEN saw_product = 0 AND bought_product = 1 THEN 1 END) AS ghost_buyers
FROM 
    user_behavior;
	
--NOW WE SEE EXACCTLY WHY : ! notice that the total carts < total purchases (some clients just skipped the cart part directly to "buy now") now lets formulate it right funnel wise 
WITH user_flow AS (
    SELECT 
        user_id,
        MAX(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS hit_view,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS hit_cart,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS hit_purchase
    FROM 
        ecommerce_events
    WHERE 
        event_time BETWEEN '2019-10-01' AND '2019-10-07'
    GROUP BY 
        user_id
)
SELECT 
    COUNT(user_id) AS total_unique_users,
    SUM(hit_view) AS total_viewers,
    SUM(hit_cart) AS total_carters,
    SUM(hit_purchase) AS total_buyers,
    
    -- יחסי המרה אמיתיים והגיוניים
    ROUND((SUM(hit_cart) * 1.0 / SUM(hit_view)) * 100, 2) AS view_to_cart_rate,
    ROUND((SUM(hit_purchase) * 1.0 / SUM(hit_view)) * 100, 2) AS overall_conversion_rate
FROM 
    user_flow;