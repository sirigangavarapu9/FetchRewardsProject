WITH recent_users AS (  
  SELECT user_id  
  FROM Users  
  WHERE created_date >= CURRENT_DATE - INTERVAL '6 month'  
),  
recent_user_receipts AS (  
  SELECT r.receipt_id, r.user_id, ri.barcode, ri.final_price * ri.quantity_purchased AS item_total  
  FROM Receipts r  
  JOIN Receipt_Items ri ON r.receipt_id = ri.receipt_id  
  WHERE r.user_id IN (SELECT user_id FROM recent_users)  
),  
receipt_items_with_brands AS (  
  SELECT rur.receipt_id, rur.user_id, rur.item_total, b.brand_id, b.name AS brand_name  
  FROM recent_user_receipts rur  
  JOIN Brands b ON rur.barcode = b.barcode  
)  
SELECT brand_id, brand_name, SUM(item_total) AS total_spend  
FROM receipt_items_with_brands  
GROUP BY brand_id, brand_name  
ORDER BY total_spend DESC  
LIMIT 1;  
