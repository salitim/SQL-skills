</* a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.*/

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;
/*Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;
/*Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/*Solutions to previous ORDER BY Questions
Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).
*/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;
Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;
/*
Compare the results of these two queries above. How are the results different when you switch the column you sort on first?
In query #1, all of the orders for each account ID are grouped together, and then within each of those groupings, the orders appear from the greatest order amount to the least. In query #2, since you sorted by the total dollar amount first, the orders appear from greatest to least regardless of which account ID they were from. Then they are sorted by account ID next. (The secondary sorting by account ID is difficult to see here, since only if there were two orders with equal total dollar amounts would there need to be any sorting by account ID.)
*/

/*Solution from previous WHERE Questions*/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;
/*
You will notice when using these WHERE statements, we do not need to ORDER BY unless we want to actually order our data. Our condition will work without having to do any sorting of the data.*/

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';
/*Note: If you received an error message when executing your query, remember that SQL requires single-quotes, not double-quotes, around text values like 'Exxon Mobil.'
*/

SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
FROM orders
LIMIT 10;
/*Here we divide the standard paper dollar amount by the total order amount to find the standard paper percent for the order, and use the AS keyword to name this new column "std_percent." You can run this query on the next page if you'd like, to see the output.
*/

/* Solutions to Arithmetic Operator Questions
Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also. NOTE - you will receive an error with the correct solution to this question. This occurs because at least one of the values in the data creates a division by zero in your formula. You will learn later in the course how to fully handle this issue. For now, you can just limit your calculations to the first 10 or
*/
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;
SELECT id, account_id, 
   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

/*start By
Solutions for LIKE operator*/
SELECT name
FROM accounts
WHERE name LIKE 'C%';
/*contain*/
SELECT name
FROM accounts
WHERE name LIKE '%one%';
/*en by*/
SELECT name
FROM accounts
WHERE name LIKE '%s';

/*Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.


Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords*/
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/*Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.

Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
Use the accounts table to find:

All the companies whose names do not start with 'C'.

All companies whose names do not contain the string 'one' somewhere in the name.

All companies whose names do not end with 's'.*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

/*Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
*/
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;
/*Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
*/
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';
/*When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.
*/
SELECT occurred_at, gloss_qty 
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;
/*You should notice that there are a number of rows in the output of this query where the gloss_qty values are 24 or 29. So the answer to the question is that yes, the BETWEEN operator in SQL is inclusive; that is, the endpoint values are included. So the BETWEEN statement in this query is equivalent to having written "WHERE gloss_qty >= 24 AND gloss_qty <= 29."

You will notice that using BETWEEN is tricky for dates! While BETWEEN is generally inclusive of endpoints, it assumes the time is at 00:00:00 (i.e. midnight) for dates. This is the reason why we set the right-side endpoint of the period at '2017-01-01'.
*/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/*Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.


Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.


Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
*/

Solutions to OR Questions
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
           AND primary_poc NOT LIKE '%eana%');


/*For example, if we want to pull only the account name and the dates in which that account placed an order, but none of the other columns, we can do this with the following query:
*/
SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
/*This query only pulls two columns, not all the information in these two tables. Alternatively, the below query pulls all the columns from both the accounts and orders table.
*/
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
/*And the first query you ran pull all the information from only the orders table:
*/
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
/********/
SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;
/*Notice this result is the same as if you switched the tables in the FROM and JOIN. Additionally, which side of the = a column is listed doesn't matter.
*/
SELECT orders.standard_qty, orders.gloss_qty, 
       orders.poster_qty,  accounts.website, 
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
/*Notice that we need to specify every table a column comes from in the SELECT statement.*/

/*Provide a table for all the for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
*/
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';
/*Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;
/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
*/
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;
/*
Solutions
Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;
/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;
/*
Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;
/*
Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price.
*/
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;
/*
Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
*/
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;
/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.
*/
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;
/*What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
*/
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';
/*Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
*/
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;
/*
When was the earliest order ever placed?*/
SELECT MIN(occurred_at) 
FROM orders;
/*Try performing the same query as in question 1 without using an aggregation function.
*/
SELECT occurred_at 
FROM orders 
ORDER BY occurred_at
LIMIT 1;
/*When did the most recent (latest) web_event occur?*/
SELECT MAX(occurred_at)
FROM web_events;
Try to perform the result of the previous query without using an aggregation function.
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;
/*Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
*/
SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
           AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
           AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;
/*Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? Note, this is more advanced than the topics we have covered thus far to build a general solution, but we can hard code a solution in the following way.
*/
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
/*
Since there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered. This is the average of 2483.16 and 2482.55. This gives the median of 2482.855. This obviously isn't an ideal way to compute. If we obtain new orders, we would have to change the limit. SQL didn't even calculate the median for us. The above used a SUBQUERY, but you could use any method to find the two necessary values, and then you just need the average of them.
*/

/*Solutions: GROUP BY
Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
*/
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;
/*Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
*/
SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;
/*Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
*/
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;
/*Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
*/
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel
/*Who was the primary contact associated with the earliest web_event?
*/
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;
/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
*/
SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;
/*Sort of strange we have a bunch of orders with no dollars. We might want to look into those.

Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
*/
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;

/*For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average spent on each of the paper types.
*/
SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(o.gloss_qty) avg_gloss, AVG(o.poster_qty) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;
/*For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
*/
SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(o.gloss_amt_usd) avg_gloss, AVG(o.poster_amt_usd) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;
/*Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
*/
SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;
/*Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
*/
SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

/*Use DISTINCT to test if there are any accounts associated with more than one region.

The below two queries have the same number of resulting rows (351), so we know that every account is associated with only one region. If each account was associated with more than one region, the first query should have returned more rows than the second query.
*/
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;
/*and*/

SELECT DISTINCT id, name
FROM accounts;
/*
Have any sales reps worked on more than one account?

Actually all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.
*/
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;
/*and*/

SELECT DISTINCT id, name
FROM sales_reps;

/*Solutions: HAVING
How many of the sales reps have more than 5 accounts that they manage?*/

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;
/*and technically, we can get this using a SUBQUERY as shown below. This same logic can be used for the other queries, but this will not be shown.
*/
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;
/*How many accounts have more than 20 orders?
*/

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;
/*Which account has the most orders?
*/
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;
/*How many accounts spent more than 30,000 usd total across all orders?
*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;
/*How many accounts spent less than 1,000 usd total across all orders?
*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;
/*Which account has spent the most with us?*/

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;
/*Which account has spent the least with us?*/

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;
/*Which accounts used facebook as a channel to contact customers more than 6 times?
*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;
/*Which account used facebook most as a channel?*/

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;
/*Note: This query above only works if there are no ties for the account that used facebook the most. It is a best practice to use a larger limit number first such as 3 or 5 to see if there are ties before using LIMIT 1.

Which channel was most frequently used by most accounts?*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;
/*All of the top 10 are direct.*/

/*Solutions: Working With DATEs
Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
*/

 SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
 FROM orders
 GROUP BY 1
 ORDER BY 2 DESC;
When we look at the yearly totals, you might notice that 2013 and 2017 have much smaller totals than all other years. If we look further at the monthly data, we see that for 2013 and 2017 there is only one month of sales for each of these years (12 for 2013 and 1 for 2017). Therefore, neither of these are evenly represented. Sales have been increasing year over year, with 2016 being the largest sales to date. At this rate, we might expect 2017 to have the largest sales.


/*Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

In order for this to be 'fair', we should remove the sales from 2013 and 2017. For the same reasons as discussed above.
*/
SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC; 
/*The greatest sales amounts occur in December (12).

Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
*/
SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
/*Again, 2016 by far has the most amount of orders, but again 2013 and 2017 are not evenly represented to the other years in the dataset.


Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
*/
SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC; 
/*December still has the most sales, but interestingly, November has the second most sales (but not the most dollar sales. To make a fair comparison from one month to another 2017 and 2013 data were removed.

In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/
SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
/* May 2016 was when Walmart spent the most on gloss paper.*/

/*Solutions: CASE
Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or less than $3000.
*/
SELECT account_id, total_amt_usd,
CASE WHEN total_amt_usd > 3000 THEN 'Large'
ELSE 'Small' END AS order_level
FROM orders;
/*Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
*/
SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
   WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
   ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;
/*We would like to understand 3 different branches of customers based on the amount associated with their purchases. The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
*/
SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;
/*We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
*/
SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;
/*We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.
*/
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;
/*It is worth mentioning that this assumes each name is unique - which has been done a few times. We otherwise would want to break by the name and the id of the table.

The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table.
*/
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;
/*You might see a few upset sales people by this criteria!*/


/*LEFT & RIGHT Solutions*/


SELECT RIGHT(website, 3) AS domain, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;
SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;
/*There are 350 company names that start with a letter and 1 that starts with a number. This gives a ratio of 350/351 that are company names that start with a letter or 99.7%.
*/
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;
/*There are 80 company names that start with a vowel and 271 that start with other characters. Therefore 80/351 are vowels or 22.8%. Therefore, 77.2% of company names do not start with vowels.
*/
SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                        THEN 1 ELSE 0 END AS vowels, 
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                       THEN 0 ELSE 1 END AS other

         FROM accounts) t1;
/*
SELECTionner la premiere colonne, la deuxieme colonne
 FROM (calcule de la premiere colonne : Cas des voyelles,
       calcules de la deuxieme colonne: Cas des numéros) nom du tableau*/

/* Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.


Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.*/
/*POSITION, STRPOS, & SUBSTR Solutions*/
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;
SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

/*Quizzes CONCAT
Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.


You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.


We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.


CONCAT Solutions*/
WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;
WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM  t1;
WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;

/*
the format of the date column is mm/dd/yyyy with times that are not correct also at the end of the date.
*/


SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;
Notice, this new date can be operated on using DATE_TRUNC and DATE_PART in the same way as earlier lessons.
SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data;

/*
Solutions to Your First Subquery
First, we needed to group by the day and channel. Then ordering by the number of events (the third column) gave us a quick way to answer the first question.
*/
SELECT DATE_TRUNC('day',occurred_at) AS day,
   channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;
/*Here you can see that to get the entire table in question 1 back, we included an * in our SELECT statement. You will need to be sure to alias your table.
*/
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
           channel, COUNT(*) as events
     FROM web_events 
     GROUP BY 1,2
     ORDER BY 3 DESC) sub;
/*Finally, here we are able to get a table that shows the average number of events a day for each channel.
*/

SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;

/*
olution: Subquery Mania
Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

First, I wanted to find the total_amt_usd totals associated with each sales rep, and I also wanted the region in which they were located. The query below provided this information.
*/
SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1,2
ORDER BY 3 DESC;
Next, I pulled the max for each region, and then we can use this to pull those rows in our final result.
SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1;
Essentially, this is a JOIN of these two tables, where the region and amount match.
SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;
/*For the region with the largest sales total_amt_usd, how many total orders were placed?

The first query I wrote was to pull the total_amt_usd for each region.*/
SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name;
Then we just want the region with the max amount from this table. There are two ways I considered getting this amount. One was to pull the max using a subquery. Another way is to order descending and just pull the top value.
SELECT MAX(total_amt)
FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY r.name) sub;
Finally, we want to pull the total orders for the region with this amount:
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
      SELECT MAX(total_amt)
      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
              FROM sales_reps s
              JOIN accounts a
              ON a.sales_rep_id = s.id
              JOIN orders o
              ON o.account_id = a.id
              JOIN region r
              ON r.id = s.region_id
              GROUP BY r.name) sub);
/*This provides the Northeast with 2357 orders.

How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

First, we want to find the account that had the most standard_qty paper. The query here pulls that account, as well as the total amount:
*/
SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
/*Now, I want to use this to pull all the accounts with more total sales:
*/
SELECT a.name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT total 
                   FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                         FROM accounts a
                         JOIN orders o
                         ON o.account_id = a.id
                         GROUP BY 1
                         ORDER BY 2 DESC
                         LIMIT 1) sub);
/*This is now a list of all the accounts with more total orders. We can get the count with just another simple subquery.
*/
SELECT COUNT(*)
FROM (SELECT a.name
       FROM orders o
       JOIN accounts a
       ON a.id = o.account_id
       GROUP BY 1
       HAVING SUM(o.total) > (SELECT total 
                   FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                         FROM accounts a
                         JOIN orders o
                         ON o.account_id = a.id
                         GROUP BY 1
                         ORDER BY 2 DESC
                         LIMIT 1) inner_tab)
             ) counter_tab;
/*For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

Here, we first want to pull the customer with the most spent in lifetime value.
*/
SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY 3 DESC
LIMIT 1;
/*Now, we want to look at the number of events on each channel this company had, which we can match with just the id.
*/
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id
                     FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                           FROM orders o
                           JOIN accounts a
                           ON a.id = o.account_id
                           GROUP BY a.id, a.name
                           ORDER BY 3 DESC
                           LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;
/*I added an ORDER BY for no real reason, and the account name to assure I was only pulling from one account.


What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

First, we just want to find the top 10 accounts in terms of highest total_amt_usd.
*/
SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY 3 DESC
LIMIT 10;
/*Now, we just want the average of these 10 amounts.*/
SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;

/*What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
*/
First, we want to pull the average of all accounts in terms of total_amt_usd:
SELECT AVG(o.total_amt_usd) avg_all
FROM orders o
Then, we want to only pull the accounts with more than this average amount.
SELECT o.account_id, AVG(o.total_amt_usd)
FROM orders o
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                               FROM orders o);
/*Finally, we just want the average of these values.*/
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                   FROM orders o)) temp_table;
/*
WITH Solutions
Below, you will see each of the previous solutions restructured using the WITH clause. This is often an easier way to read a query.

Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC), 
t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;
/*For the region with the largest sales total_amt_usd, how many total orders were placed?
*/
WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name), 
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);
/*For the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?
*/
WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1), 
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;
/*For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
*/
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;
/*What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 10)
SELECT AVG(tot_spent)
FROM t1;
/*
What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
*/
WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;
/*
Creating a Running Total Using Window Functions
Using Derek's previous video as an example, create another running total. This time, create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.*/
SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders
/*
Creating a Partitioned Running Total Using Window Functions
Now, modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. Your final table should have three columns: One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year.
reating a Partitioned Running Total Using Window Functions*/
SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders

/*
Now, create and use an alias to shorten the following query (which is different than the one in Derek's previous video) that has multiple window functions. Name the alias account_year_window, which is more descriptive than main_window in the example above.
*/
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS count_total_amt_usd,
       AVG(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS min_total_amt_usd,
       MAX(total_amt_usd) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at)) AS max_total_amt_usd
FROM orders
/*
Ranking Total Paper Ordered by Account*/
SELECT id,
       account_id,
       total,
       RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders


/*Percentiles with Partitions

Percentiles with Partitions
You can use partitions with percentiles to determine the percentile of a specific subset of all rows. Imagine you're an analyst at Parch & Posey and you want to determine the largest orders (in terms of quantity) a specific customer has made to encourage them to order more similarly sized large orders. You only want to consider the NTILE for that customer's account_id.

In the SQL Explorer below, write three queries (separately) that reflect each of the following:

Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, and one of four levels in a standard_quartile column.


Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.


Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column.


Note: To make it easier to interpret the results, order by the account_id in each of the queries.


1.*/
SELECT
       account_id,
       occurred_at,
       standard_qty,
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
  FROM orders 
 ORDER BY account_id DESC
/*2.*/
SELECT
       account_id,
       occurred_at,
       gloss_qty,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
  FROM orders 
 ORDER BY account_id DESC
/*3.*/
SELECT
       account_id,
       occurred_at,
       total_amt_usd,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
  FROM orders 
 ORDER BY account_id DESC

/*
 QUESTION 1 OF 3
Let's start with creating a table that provides the following details: actor's first and last name combined as full_name, film title, film description and length of the movie.

How many rows are there in the table?*/

SELECT 
CONCAT(first_name, ' ' , last_name) full_name,
title,
description,
length
FROM   film_actor fa
JOIN   actor a
ON     fa.actor_id = a.actor_id
JOIN   film f
ON     f.film_id = fa.film_id
/*where movie length wa more than 60 minutes*/
SELECT 
CONCAT(first_name, ' ' , last_name) full_name,
title,
description,
length
FROM   film_actor fa
JOIN   actor a
ON     fa.actor_id = a.actor_id
JOIN   film f
ON     f.film_id = fa.film_id
WHERE length > 60;

/*Question 3: Write a query that captures the full name of the actor, and counts the number of movies each actor has made. Identify the actor who has made the maximum number of movies.*/
SELECT actorid, full_name, 
       COUNT(filmtitle) film_count_peractor
FROM
    (SELECT a.actor_id actorid,
            a.first_name, 
            a.last_name,
            a.first_name || ' ' || a.last_name AS full_name,
            f.title filmtitle
    FROM    film_actor fa
    JOIN    actor a
    ON      fa.actor_id = a.actor_id
    JOIN    film f
    ON      f.film_id = fa.film_id) t1
GROUP BY 1, 2
ORDER BY 3 DESC

/*Write a query that creates a table with 4 columns: actor's full name, film title, length of movie, and a column name "filmlen_groups" that classifies movies based on their length. Filmlen_groups should include 4 categories: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.*/

SELECT full_name, 
       filmtitle,
       filmlen,
       CASE WHEN filmlen <= 60 THEN '1 hour or less'
       WHEN filmlen > 60 AND filmlen <= 120 THEN 'Between 1-2 hours'
       WHEN filmlen > 120 AND filmlen <= 180 THEN 'Between 2-3 hours'
       ELSE 'More than 3 hours' END AS filmlen_groups
FROM 
    (SELECT a.first_name, 
               a.last_name,
               a.first_name || ' ' || a.last_name AS full_name,
               f.title filmtitle, 
               f.length filmlen
        FROM film_actor fa
        JOIN actor a
        ON fa.actor_id = a.actor_id
        JOIN film f
        ON f.film_id = fa.film_id) t1

   /*     Question 2: Write a query you to create a count of movies in each of the 4 filmlen_groups: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.
*/

SELECT    DISTINCT(filmlen_groups),
          COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencat
FROM  
         (SELECT title,length,
          CASE WHEN length <= 60 THEN '1 hour or less'
          WHEN length > 60 AND length <= 120 THEN 'Between 1-2 hours'
          WHEN length > 120 AND length <= 180 THEN 'Between 2-3 hours'
          ELSE 'More than 3 hours' END AS filmlen_groups
          FROM film ) t1
ORDER BY  filmlen_groups

/**Projet DVD rental***/
/*question 1*/

WITH t1 AS (
SELECT 
f.title film_title,
cat.name category_name,
COALESCE(r.rental_id) rental
FROM category cat
JOIN film_category f_cat
ON f_cat.category_id = cat.category_id
JOIN film f
ON f_cat.film_id = f.film_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
)

SELECT 
film_title,
category_name,
COUNT(*) rental_count
FROM t1
GROUp BY 1,2
ORDER BY 2;
/*** avec les catégorie ***/
WITH t1 AS (
            SELECT 
            f.title film_title,
            cat.name category_name,
            COALESCE(r.rental_id) rental
            FROM category cat
            JOIN film_category f_cat
            ON f_cat.category_id = cat.category_id
            JOIN film f
            ON f_cat.film_id = f.film_id
            JOIN inventory i
            ON i.film_id = f.film_id
            JOIN rental r
            ON i.inventory_id = r.inventory_id
			WHERE cat.name = 'Animation' 
			OR cat.name = 'Children'
			OR cat.name = 'Classics' 
			OR cat.name = 'Comedy'
			OR cat.name = 'Family'
			OR cat.name = 'Music'
)

SELECT DISTINCT film_title,
category_name,
COUNT(*) OVER(PARTITION BY film_title) AS rental_count
FROM t1
ORDER BY 2,1;
/*** Q2***/

WITH t1 AS (
            SELECT 
            f.title film_title,
            cat.name category_name,
            f.rental_duration 
            FROM category cat
            JOIN film_category f_cat
            ON f_cat.category_id = cat.category_id
            JOIN film f
            ON f_cat.film_id = f.film_id
			WHERE cat.name = 'Animation' 
			OR cat.name = 'Children'
			OR cat.name = 'Classics' 
			OR cat.name = 'Comedy'
			OR cat.name = 'Family'
			OR cat.name = 'Music'
			
)

SELECT film_title,
category_name,
rental_duration,
NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
FROM t1
ORDER BY 3;


/***Q3***/

WITH t1 AS (
            SELECT 
            DISTINCT cat.name AS category_name,
            NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile,
			f.film_id AS film_id
            FROM category cat
            JOIN film_category f_cat
            ON f_cat.category_id = cat.category_id
            JOIN film f
            ON f_cat.film_id = f.film_id
			WHERE cat.name = 'Animation' 
			OR cat.name = 'Children'
			OR cat.name = 'Classics' 
			OR cat.name = 'Comedy'
			OR cat.name = 'Family'
			OR cat.name = 'Music'
			
)

SELECT category_name,
standard_quartile,
COUNT(*) 
FROM t1 
GROUP BY 1, 2
ORDER BY 1, 2;

