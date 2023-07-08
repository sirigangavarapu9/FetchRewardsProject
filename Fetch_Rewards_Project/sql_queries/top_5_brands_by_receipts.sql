WITH recent_month_receipts AS (  
  SELECT receipt_id  
  FROM Receipts  
  WHERE date_scanned >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'  
    AND date_scanned < DATE_TRUNC('month', CURRENT_DATE)  
),  
receipt_items_with_brands AS (  
  SELECT ri.receipt_id, b.brand_id, b.name AS brand_name  
  FROM Receipt_Items ri  
  JOIN Brands b ON ri.barcode = b.barcode  
  WHERE ri.receipt_id IN (SELECT receipt_id FROM recent_month_receipts)  
)  
SELECT brand_id, brand_name, COUNT(receipt_id) AS receipts_scanned  
FROM receipt_items_with_brands  
GROUP BY brand_id, brand_name  
ORDER BY receipts_scanned DESC  
LIMIT 5;  


