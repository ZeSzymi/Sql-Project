use Shop
select name, Count(company.id) as how_many_sold from company
inner join invoice on invoice.company = company.id group by name