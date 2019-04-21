use Shop
select firstname, surname, Sum(price) as total_price from client
Inner join invoice on client.id = invoice.client Group by firstname, surname
