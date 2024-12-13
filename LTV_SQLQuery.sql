-- Total Revenue per Customer: The sum of all transaction amounts per customer
SELECT customer_id, SUM(revenue) AS TotalRevenue
FROM Transactions
GROUP BY customer_id;

-- Purchase Frequency: The number of purchases per customer over a specific period.
SELECT customer_id, COUNT(*) AS PurchaseFrequency
FROM Transactions
GROUP BY customer_id;

-- Average Purchase Value: The average transaction amount per purchase for each customer.
SELECT customer_id, AVG(revenue) AS AvgPurchaseValue
FROM Transactions
GROUP BY customer_id;

-- CLV=(Average Purchase Value×Purchase Frequency)−Acquisition Cost.
WITH CLVTable AS(   
    SELECT 
        customer_id,
        channel,
        AVG(revenue) AS AvgPurchaseValue,
        COUNT(*) AS PurchaseFrequency,
        (AVG(revenue) * COUNT(*)) - MIN(cost) AS CLV
    FROM 
        Transactions
    GROUP BY 
        customer_id,channel )

/* With CLV calculated, segment customers into groups (e.g., high, medium, low value) to tailor
 marketing  strategies and customer relationship efforts */

 SELECT customer_id, channel, CLV,
       CASE
           WHEN CLV >= 1000 THEN 'High Value'
           WHEN CLV BETWEEN 500 AND 999 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS CLVSegment
FROM CLVTable;