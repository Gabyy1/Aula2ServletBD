Create DataBase Aula1LabBD
Go
Use Aula1LabBD
Go

Create Table Motorista (
Codigo			int				not null,
Nome			varchar(80)		not null,
Naturalidade	varchar(30)		not null
Primary Key (Codigo)
)
Go

Create Table Onibus (
Placa			varchar(7)		not null,
Marca			varchar(30)		not null,
Ano				int				not null,
Descricao		varchar(30)		not null
Primary Key (Placa)
)
Go

Create Table Viagem (
Codigo				int							not null,
PlacaOnibus			varchar(7)					not null,
CodigoMotorista		int							not null,
HoraSaida			int Check(HoraSaida>=0)		not null,
HoraChegada			int Check(HoraChegada>=0)	not null,
Partida				varchar(30)					not null,
Destino				varchar(30)					not null
Primary Key(Codigo, PlacaOnibus, CodigoMotorista)
Foreign Key (PlacaOnibus)
	References Onibus (Placa),
Foreign Key (CodigoMotorista)
	References Motorista (Codigo)
)
Go

Insert Motorista Values 
(12341,	'Julio Cesar',	'São Paulo'),
(12342,	'Mario Carmo',	'Americana'),
(12343,	'Lucio Castro',	'Campinas'),
(12344,	'André Figueiredo',	'São Paulo'),
(12345,	'Luiz Carlos',	'São Paulo'),
(12346,	'Carlos Roberto',	'Campinas'),
(12347,	'João Paulo',	'São Paulo')

Insert Onibus Values 
('adf0965',	'Mercedes',	2009,	'Leito'),
('bhg7654',	'Mercedes',	2012,	'Sem Banheiro'),
('dtr2093',	'Mercedes',	2017,	'Ar Condicionado'),
('gui7625',	'Volvo',	2014,	'Ar Condicionado'),
('jhy9425',	'Volvo',	2018,	'Leito'),
('lmk7485',	'Mercedes',	2015,	'Ar Condicionado'),
('aqw2374',	'Volvo',	2014,	'Leito')

Insert Viagem Values
(101,	'adf0965',	12343,	10,	12,	'São Paulo',	'Campinas'),
(102,	'gui7625',	12341,	7,	12,	'São Paulo',	'Araraquara'),
(103,	'bhg7654',	12345,	14,	22,	'São Paulo',	'Rio de Janeiro'),
(104,	'dtr2093',	12344,	18,	21,	'São Paulo',	'Sorocaba'),
(105,	'aqw2374',	12342,	11,	17,	'São Paulo',	'Ribeirão Preto'),
(106,	'jhy9425',	12347,	10,	19,	'São Paulo',	'São José do Rio Preto'),
(107,	'lmk7485',	12346,	13,	20,	'São Paulo',	'Curitiba'),
(108,	'adf0965',	12343,	14,	16,	'Campinas',	'São Paulo'),
(109,	'gui7625',	12341,	14,	19,	'Araraquara',	'São Paulo'),
(110,	'bhg7654',	12345,	0,	8,	'Rio de Janeiro',	'São Paulo'),
(111,	'dtr2093',	12344,	22,	1,	'Sorocaba',	'São Paulo'),
(112,	'aqw2374',	12342,	19,	5,	'Ribeirão Preto',	'São Paulo'),
(113,	'jhy9425',	12347,	22,	7,	'São José do Rio Preto',	'São Paulo'),
(114,	'lmk7485',	12346,	0,	7,	'Curitiba',	'São Paulo')


--1) Criar um Union das tabelas Motorista e ônibus, com as colunas ID (Código e Placa) e 
--Nome (Nome e Marca)	

Select 	Convert(varchar(7), Codigo) As ID,
Nome As Nome	
From Motorista
Union
Select Placa As ID,
Marca As Nome
From Onibus

--2) Criar uma View (Chamada v_motorista_onibus) do Union acima	
				
Create View v_MotoristaOnibus As 
Select 	Convert(varchar(7), Codigo) As ID,
Nome As Nome	
From Motorista
Union 
Select Placa As ID,
Marca As Nome
From Onibus

--3) Criar uma View (Chamada v_descricao_onibus) que mostre o Código da Viagem, 
--o Nome do motorista, a placa do ônibus (Formato XXX-0000), a Marca do ônibus, 
--o Ano do ônibus e a descrição do onibus														
	
Create View v_descricao_onibus As
Select Viagem.Codigo As Codigo,
Nome As Nome,
Substring(Placa, 1, 3) + '-' + Substring(Placa, 4,4) As Placa,
Marca As Marca,
Ano As Ano,
Descricao As Descricao
From Motorista Inner Join Viagem
On  Motorista.Codigo = Viagem.CodigoMotorista
Inner Join Onibus 
On Onibus.Placa = Viagem.PlacaOnibus

Select*From v_descricao_onibus

--4) Criar uma View (Chamada v_descricao_viagem) que mostre o Código da viagem, 
--a placa do ônibus(Formato XXX-0000), a Hora da Saída da viagem (Formato HH:00), 
--a Hora da Chegada da viagem (Formato HH:00), partida e destino	
Create View v_descricao_viagem As
Select Viagem.Codigo As Codigo,	
Substring(Placa, 1, 3) + '-' + Substring(Placa, 4,4) As Placa,													
Cast(HoraSaida As Varchar(2)) + ':00' AS Saida,
Cast(HoraChegada As Varchar(2)) + ':00' AS Chegada,
Partida As Partida,
Destino As Destino
From Onibus Inner Join Viagem 
On Onibus.Placa = Viagem.PlacaOnibus
Inner Join Motorista 
On Motorista.Codigo = Viagem.CodigoMotorista

Select*FRom v_descricao_viagem








