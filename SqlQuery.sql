CREATE TABLE osoba_prawna (
    nazwa nvarchar(50) primary key,
    nip varchar(10) ,
	adres nvarchar(50),
	nazwisko nvarchar(50),
	telefon varchar(50),
	email varchar(50)
);
 GO

CREATE TABLE osoba_fizyczna (
    imie nvarchar(50) primary key,
    nazwisko varchar(10) ,
	adres nvarchar(50),
	telefon varchar(50)
);
Go

CREATE TABLE typ_kosmetyku(
	typ nvarchar(50) primary key,
);
Go

Create TABLE kosmetyk(
	nazwa nvarchar(60) primary key,
	producent nvarchar(60),
	typ_kosmetyku nvarchar(50) references typ_kosmetyku(typ),
	constraint typ_kos_typ unique (typ_kosmetyku)
);
Go

Create Table faktura(
	id integer primary key,
	kosmetyk nvarchar(60) references kosmetyk(nazwa),
	constraint faktura_komsetyk unique (kosmetyk),
	cena integer,
	ilosc_sztuk integer,
)