SELECT rewards_receipt_status, AVG(total_spent) AS average_spend  
FROM Receipts  
WHERE rewards_receipt_status IN ('Accepted', 'Rejected')  
GROUP BY rewards_receipt_status;  
