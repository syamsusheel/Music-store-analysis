
-- 1. Senior most employee
SELECT * 
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- 2. Country with most invoices
SELECT billing_country, COUNT(*) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC
LIMIT 1;

-- 3. Top 3 highest invoice values
SELECT total 
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- 4. City with highest invoice total
SELECT billing_city, SUM(total) AS revenue
FROM invoice
GROUP BY billing_city
ORDER BY revenue DESC
LIMIT 1;

-- 5. Best customer by total purchase
SELECT customer_id, SUM(total) AS total_spent
FROM invoice
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- 6. List all Rock music listeners
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock';

-- 7. Top 10 artists with most rock songs
SELECT a.name, COUNT(*) AS rock_song_count
FROM artist a
JOIN album al ON a.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY a.name
ORDER BY rock_song_count DESC
LIMIT 10;

-- 8. Songs longer than average
SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;

-- 9. Amount spent by customer on a specific artist (e.g., "Queen")
SELECT c.customer_id, c.first_name, c.last_name, SUM(il.unit_price * il.quantity) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN album a ON t.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE ar.name = 'Queen'
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- 10. Most popular genre per country
SELECT billing_country, g.name AS genre, COUNT(*) AS purchases
FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY billing_country, genre
ORDER BY billing_country, purchases DESC;

-- 11. Top spending customer in each country
SELECT billing_country, customer_id, SUM(total) AS total_spent
FROM invoice
GROUP BY billing_country, customer_id
ORDER BY billing_country, total_spent DESC;
