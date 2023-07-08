WITH accepted_rejected_receipts AS (  
  SELECT receipt_id  
  FROM Receipts  
  WHERE rewards_receipt_status IN ('Accepted', 'Rejected')  
),  
receipt_items_count AS (  
  SELECT receipt_id, SUM(quantity_purchased) AS items_purchased  
  FROM Receipt_Items  
  WHERE receipt_id IN (SELECT receipt_id FROM accepted_rejected_receipts)  
  GROUP BY receipt_id  
)  
SELECT r.rewards_receipt_status, SUM(ric.items_purchased) AS total_items_purchased  
FROM Receipts r  
JOIN receipt_items_count ric ON r.receipt_id = ric.receipt_id  
WHERE r.rewards_receipt_status IN ('Accepted', 'Rejected')  
GROUP BY r.rewards_receipt_status;  
