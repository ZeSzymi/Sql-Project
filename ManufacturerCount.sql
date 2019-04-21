use Shop
select manufacturer, sum(quantity) as total_quantity from manufacturer
Inner join cosmetic on cosmetic.manufacturer = manufacturer.name
Inner join invoice on invoice.cosmetic = cosmetic.name
Where manufacturer = 'givenchy' group by manufacturer