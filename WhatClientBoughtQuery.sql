use Shop
select firstname, surname, phone, cosmetic, price, quantity from client
inner join invoice on client.id = invoice.client where client = 3;