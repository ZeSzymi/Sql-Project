CREATE DATABASE Shop;

GO 

USE Shop;

GO 


CREATE TABLE company (
	id integer  IDENTITY(1,1) PRIMARY KEY NOT NULL,
	surname nvarchar(50) NOT NULL,
    name nvarchar(50) NOT NULL,
    nip varchar(10) NOT NULL ,
	address nvarchar(50) NOT NULL,
	phone varchar(9) NOT NULL,
	email varchar(50) NOT NULL,
	constraint chknumbers CHECK ( nip NOT LIKE '%[^0-9]%' and phone NOT LIKE '%[^0-9]%')
);


insert into company(surname, name, nip, address, phone, email)
values ('Nowak','Nowak Industries','2940640431','Pilotów 5/32','632055443','nowak@inustries.pl'),
('Kowalski','Kowal Inc.','2432640431','Wadowicka 78/26','634675443','kowal@inc.pl'),
('Czarny','Okno-Pol','4322640431','Rzemieślnicza 54/22','638735443','czarny@oknopol.pl'),
('Biały','Bramex','2932640431','Kamieńskiego 3/4','632365443','bialy@bramex.pl'),
('Myszon','doIT','8902640431','Kamieńskiego 3/4','632365443','myszon@doIT.pl');
 GO

CREATE TABLE client (
	id integer  IDENTITY(1,1) PRIMARY KEY NOT NULL,
	surname nvarchar(50) NOT NULL,
	firstname nvarchar(50) NOT NULL,
	address nvarchar(50) NOT NULL,
	phone varchar(50) NOT NULL,
	constraint chktelefon CHECK (phone NOT LIKE '%[^0-9]%')
);

insert into client(surname, firstname, address, phone)
values ('Skotnicki','Artur','Chrobrego 2/12','631455443'),
('Frasołowicz','Agata','Mickiewicza 3/8','647955443'),
('Niegoda','Magdalena','Buraczana 5/18','631455443'),
('Jagieło','Władysław','Grunwaldzka 14/10','658155443'),
('Mazur','Aleksandra','Wadowicka 15/87','658155997');

Go

CREATE TABLE cosmetic_type(
	type nvarchar(50) primary key NOT NULL,
);
insert into cosmetic_type(type)
values ('popular'),
('luxury');

Go

CREATE TABLE cosmetic_group(
	c_group nvarchar(50) primary key NOT NULL,
);
insert into cosmetic_group(c_group)
values ('perfume'),
('perfume x'),
('soaps'),
('shampoo'),
('creams');
Go

CREATE TABLE manufacturer(
	name nvarchar(50) primary key NOT NULL,
);
go

Create TABLE cosmetic(
	name nvarchar(50) primary key NOT NULL,
	manufacturer nvarchar(50) references manufacturer(name) NOT NULL,
	constraint manufacturer_cosmetic unique (manufacturer),
	cosmetic_type nvarchar(50) NOT NULL,
	cosmetic_group nvarchar(50) NOT NULL,
	foreign key (cosmetic_type) references cosmetic_type on delete cascade on update cascade,
	foreign key (cosmetic_group) references cosmetic_group on delete cascade on update cascade,
);
Go

insert into manufacturer values 
('armani'),
('givenchy'),
('wella'),
('nivea'),
('dermatic'),
('nana'),
('mariniqa'),
('h2o'),
('mint'),
('pilos');

go

insert into cosmetic(name, manufacturer, cosmetic_type, cosmetic_group)
values ('chy', 'givenchy', 'luxury', 'perfume'),
('si passione', 'h2o', 'popular', 'perfume'),
('acqua', 'pilos', 'luxury', 'perfume x'),
('emporio', 'armani', 'popular', 'perfume x'),
('elements', 'wella', 'popular', 'shampoo'),
('capilarte', 'dermatic', 'luxury', 'shampoo'),
('rokitnik', 'mariniqa', 'popular', 'soaps'),
('aloes', 'mint', 'luxury', 'soaps'), 
('creme', 'nivea', 'popular', 'creams'),
('neurokrem', 'nana', 'luxury', 'creams');
Go

Create Table invoice(
	id integer IDENTITY(1,1) PRIMARY KEY NOT NULL,
	price integer NOT NULL,
	quantity integer NOT NULL,
	cosmetic nvarchar(50) NOT NULL,
	client integer,
	company integer,
	foreign key (cosmetic) references cosmetic on delete cascade on update cascade,
	foreign key (client) references client on delete cascade on update cascade,
	foreign key (company) references company on delete cascade on update cascade,
)

go
insert into invoice(price, quantity, cosmetic, client, company)
values (150, 3, 'aloes', 3, null), 
(700, 7, 'acqua', 2, null),
(5500, 15, 'chy', null, 4),
(50, 3, 'aloes', 1, null),
(1200, 10, 'si passione', null, 1),
(3000, 120, 'rokitnik', null, 2),
(3500, 3000, 'creme', null, 3),
(2000, 35, 'emporio', null, 4),
(2800, 80, 'neurokrem', null, 5),
(200, 5, 'capilarte', null, 1),
(500, 1, 'chy', 1, null),
(20, 3, 'aloes', 2, null),
(30, 3, 'rokitnik', 3, null),
(25, 8, 'creme', 4, null),
(500, 30, 'si passione', 5, null),
(2000, 100, 'acqua', 4, null);
go
select firstname, surname, Sum(price) as total_price from client
Inner join invoice on client.id = invoice.client Group by firstname, surname
go
select manufacturer, sum(quantity) as total_quantity from manufacturer
Inner join cosmetic on cosmetic.manufacturer = manufacturer.name
Inner join invoice on invoice.cosmetic = cosmetic.name
Where manufacturer = 'givenchy' group by manufacturer
go
select AVG(price) as average_price from invoice
go
select firstname, surname, phone, cosmetic, price, quantity from client
inner join invoice on client.id = invoice.client where client = 3;
go
select name, Count(company.id) as how_many_sold from company
inner join invoice on invoice.company = company.id group by name