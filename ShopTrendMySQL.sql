USE practice1;
SELECT * FROM shop;

-- Q1)  What is the average purchase amount for each category of items?

SELECT Category, truncate(avg(PurchaseAmount),2) as Average
FROM shop 
GROUP BY Category;


-- Q2) Which state has the highest numbers of customers who purchased clothing item?

SELECT Location, COUNT(*) AS Number 
FROM shop
WHERE Category = 'Clothing'
GROUP BY Location
ORDER BY COUNT(*) DESC
LIMIT 5;


-- Q3) What is the most popular colour for footware items among male customers?

SELECT Color, COUNT(*) as Frequency, ReviewRating
FROM shop
WHERE Category = 'Footwear' AND
Gender = 'Male'
GROUP BY Color, ReviewRating
ORDER BY COUNT(*) DESC
LIMIT 5;


-- Q4) How does the review rating vary by season and category?
(SELECT DISTINCT Category, Season, ReviewRating,
CASE WHEN COUNT(*) >=25 THEN 'high'
			 WHEN COUNT(*) <=25 THEN 'Medium'
			 WHEN COUNT(*) <15 THEN 'Low'
END AS Frequency
FROM shop
GROUP BY Category, Season, ReviewRating
HAVING Frequency = 'high'
ORDER BY Frequency
LIMIT 3)
UNION
(SELECT DISTINCT Category, Season, ReviewRating,
CASE WHEN COUNT(*) >=25 THEN 'high'
			 WHEN COUNT(*) <=25 THEN 'Medium'
			 WHEN COUNT(*) <15 THEN 'Low'
END AS Frequency
FROM shop
GROUP BY Category, Season, ReviewRating
HAVING Frequency = 'Medium'
ORDER BY Frequency
LIMIT 5)
UNION
(SELECT DISTINCT Category, Season, ReviewRating,
CASE WHEN COUNT(*) >=25 THEN 'high'
			 WHEN COUNT(*) <=25 THEN 'Medium'
			 WHEN COUNT(*) <15 THEN 'Low'
END AS Frequency
FROM shop
GROUP BY Category, Season, ReviewRating
HAVING Frequency = 'Low'
LIMIT 3);


-- Q5) Which shipping type has the highest customer satisfaction rate?

SELECT DISTINCT ShippingType, ReviewRating, COUNT(ReviewRating) AS Frequency
FROM shop
GROUP BY ShippingType, ReviewRating
ORDER BY ReviewRating DESC, Frequency DESC
LIMIT 5;


-- Q6) How many customers use promo code for their purchases?

SELECT TRUNCATE(COUNT(*)/100,2) AS Frequency
FROM shop
WHERE PromoCodeUsed = 'Yes';


-- Q7) What is the distribution of age groups of customers?


SELECT DISTINCT CASE
            WHEN Age BETWEEN 18 AND 30 THEN '18-30'
            WHEN Age BETWEEN 31 AND 50 THEN '31-50'
            WHEN Age BETWEEN 51 AND 70 THEN '51-70'
END AS Age_Grops
FROM shop;


-- Q8) Which item has lowest and highest review rating?

(SELECT ItemPurchased, ReviewRating
FROM shop
ORDER BY ReviewRating DESC
LIMIT 1)
UNION
(SELECT ItemPurchased, ReviewRating
FROM shop
ORDER BY ReviewRating ASC
LIMIT 1);


-- Q9) How does the size of clothing item affect the purchase amount?

select distinct size, count(size), case
				when PurchaseAmount between 20 and 50 then 'cheap'
                when PurchaseAmount between 51 and 80 then 'Moderate'
                when PurchaseAmount between 81 and 100 then 'expensive'
end as pRange,
case 
         when PurchaseAmount between 20 and 50 then '20-50'
		 when PurchaseAmount between 51 and 80 then '51-80'
		 when PurchaseAmount between 81 and 100 then '81-100'
end as PrRange
from shop
where Category = 'Clothing'
group by size, pRange, PrRange
order by length(pRange) desc, count(size) desc;




/*
Conclusion :-- 

               This report has explored various aspects of online shopping behavior, such as purchase amount, customer preferences, 
               review ratings, payment methods, shipping types, promo codes, and age groups. 
               The report has found that clothing items are the most popular category, followed by accessories and footwear. 
*/




