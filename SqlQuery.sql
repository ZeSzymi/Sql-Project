CREATE DATABASE Sklep;

GO 

USE Sklep;

GO 


CREATE TABLE osoba_prawna (
	id integer  IDENTITY(1,1) PRIMARY KEY NOT NULL,
	nazwisko nvarchar(50) NOT NULL,
    nazwa nvarchar(50) NOT NULL,
    nip varchar(10) NOT NULL ,
	adres nvarchar(50) NOT NULL,
	telefon varchar(9) NOT NULL,
	email varchar(50) NOT NULL
);


insert into osoba_prawna (nazwisko, nazwa, nip, adres, telefon, email)
values ('Nowak','Nowak Industries','2940640431','Pilotów 5/32','632055443','nowak@inustries.pl');
 GO

CREATE TABLE osoba_fizyczna (
	id integer  IDENTITY(1,1) PRIMARY KEY NOT NULL,
	nazwisko nvarchar(50),
	imie nvarchar(50) ,
	adres nvarchar(50),
	telefon varchar(50),
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
	osoba_prawna integer references osoba_prawna(id),
	constraint osoba_prawna_nazwa unique (osoba_prawna),
	osoba_fizyczna integer references osoba_fizyczna(id),
	constraint osoba_fizyczna_id unique (osoba_fizyczna),
)
