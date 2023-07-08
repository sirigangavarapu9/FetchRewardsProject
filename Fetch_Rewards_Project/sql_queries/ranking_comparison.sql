WITH recent_month_receipts AS (  
  SELECT receipt_id  
  FROM Receipts  
  WHERE date_scanned >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'  
    AND date_scanned < DATE_TRUNC('month', CURRENT_DATE)  
),  
previous_month_receipts AS (  
  SELECT receipt_id  
  FROM Receipts  
  WHERE date_scanned >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 month'  
    AND date_scanned < DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'  
),  
receipt_items_with_brands AS (  
  SELECT ri.receipt_id, b.brand_id, b.name AS brand_name  
  FROM Receipt_Items ri  
  JOIN Brands b ON ri.barcode = b.barcode  
),  
recent_month_ranking AS (  
  SELECT brand_id, brand_name, COUNT(receipt_id) AS receipts_scanned  
  FROM receipt_items_with_brands  
  WHERE receipt_id IN (SELECT receipt_id FROM recent_month_receipts)  
  GROUP BY brand_id, brand_name  
),  
previous_month_ranking AS (  
  SELECT brand_id, brand_name, COUNT(receipt_id) AS receipts_scanned  
  FROM receipt_items_with_brands  
  WHERE receipt_id IN (SELECT receipt_id FROM previous_month_receipts)  
  GROUP BY brand_id, brand_name  
),  
recent_month_top_5 AS (  
  SELECT brand_id, brand_name, receipts_scanned,  
         RANK() OVER (ORDER BY receipts_scanned DESC) AS recent_month_rank  
  FROM recent_month_ranking  
),  
previous_month_top_5 AS (  
  SELECT brand_id, brand_name, receipts_scanned,  
         RANK() OVER (ORDER BY receipts_scanned DESC) AS previous_month_rank  
  FROM previous_month_ranking  
)  
SELECT r.brand_id, r.brand_name, r.recent_month_rank, p.previous_month_rank  
FROM recent_month_top_5 r  
JOIN previous_month_top_5 p ON r.brand_id = p.brand_id  
ORDER BY r.recent_month_rank;  
