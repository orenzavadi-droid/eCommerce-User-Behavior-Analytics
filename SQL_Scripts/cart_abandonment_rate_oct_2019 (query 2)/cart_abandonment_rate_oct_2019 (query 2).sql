WITH session_product_events AS (
    SELECT 
        user_session,
        category_id,
        product_id,
        price,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS added_to_cart,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM 
        ecommerce_events
    WHERE 
        event_time BETWEEN '2019-10-01' AND '2019-10-07'
    GROUP BY 
        user_session, category_id, product_id, price
)
SELECT 
    category_id,
    SUM(added_to_cart) AS total_cart_additions,
    SUM(CASE WHEN added_to_cart = 1 AND purchased = 0 THEN 1 ELSE 0 END) AS total_abandonments,
    ROUND(
        (SUM(CASE WHEN added_to_cart = 1 AND purchased = 0 THEN 1 ELSE 0 END) * 1.0 / 
        NULLIF(SUM(added_to_cart), 0)) * 100, 2
    ) AS cart_abandonment_rate,
    ROUND(AVG(CASE WHEN added_to_cart = 1 AND purchased = 0 THEN price END), 2) AS avg_abandoned_price
FROM 
    session_product_events
WHERE 
    added_to_cart = 1
GROUP BY 
    category_id
HAVING 
    SUM(added_to_cart) > 10 -- סינון קטגוריות עם פעילות נמוכה מדי
ORDER BY 
    cart_abandonment_rate DESC
LIMIT 10; -- נסתכל על המקומות הראשונים