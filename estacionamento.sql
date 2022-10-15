CREATE TABLE CLIENTE(
	cpf varchar(14),
	nome varchar(60),
	dtnasc date,	
	CONSTRAINT pk_cliente PRIMARY KEY (cpf)
);
INSERT INTO CLIENTE VALUES ('111.111.111-11','Sylvio Barbon', TO_DATE('05/12/1984', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('222.222.222-22','Joao das couves', TO_DATE('05/01/1970', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('333.333.333-33','Fulando de tal', TO_DATE('24/06/1987', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('444.444.444-44','Cicrano', TO_DATE('15/07/1989', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('555.555.555-55','Roberval de Jesus', TO_DATE('01/04/1985', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('666.666.666-66','Anastacia das flores', TO_DATE('20/02/1969', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('777.777.777-77','Charleston Ribeiro', TO_DATE('11/10/1947', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('888.888.888-88','Aline Mariano', TO_DATE('01/12/1995', 'DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('999.999.999-99','Geisy Dias', TO_DATE('06/08/1990', 'DD/MM/YYYY'));
SELECT * FROM CLIENTE;

CREATE TABLE MODELO(
	codMod serial PRIMARY KEY,
	descModelo varchar(40)
);
INSERT INTO MODELO (descModelo) VALUES ('COROLLA');
INSERT INTO MODELO (descModelo) VALUES ('HILUX');
INSERT INTO MODELO (descModelo) VALUES ('SW4');
INSERT INTO MODELO (descModelo) VALUES ('PAMPA');
INSERT INTO MODELO (descModelo) VALUES ('TORO');
INSERT INTO MODELO (descModelo) VALUES ('BMW');
INSERT INTO MODELO (descModelo) VALUES ('JEEP');
SELECT * FROM MODELO;

CREATE TABLE patio(
	codPatio serial PRIMARY KEY,
	endereco varchar(40),
	capacidade int
);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_01', 10);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_02', 20);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_03', 30);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_04', 40);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_05', 50);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_06', 60);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_07', 70);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_08', 80);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_09', 90);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_10', 100);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_11', 110);
INSERT INTO PATIO (endereco, capacidade) VALUES ('PATIO_12', 120);
SELECT * FROM PATIO;

CREATE TABLE VEICULO(
	placa varchar(8) PRIMARY KEY,
	cor varchar(20),
	ano int,
	codMod int,
	cpf varchar(14),
	CONSTRAINT fk_codMod FOREIGN KEY (codMod) REFERENCES MODELO (codMod),
	CONSTRAINT fk_cpf FOREIGN KEY (cpf) REFERENCES CLIENTE (cpf)
);
INSERT INTO VEICULO VALUES ('JJJ2J20','VERDE',2000,1,'111.111.111-11');
INSERT INTO VEICULO VALUES ('ABC1A11','AMARELO',2001,2,'222.222.222-22');
INSERT INTO VEICULO VALUES ('KBG9454','AZUL',2002,3,'333.333.333-33');
INSERT INTO VEICULO VALUES ('KUV4063','VERMELHO',2003,4,'444.444.444-44');
INSERT INTO VEICULO VALUES ('HRO9633','PRETO',2004,5,'555.555.555-55');
INSERT INTO VEICULO VALUES ('HZU3858','PRATA',2005,6,'666.666.666-66');
INSERT INTO VEICULO VALUES ('MOK1513','BRANCO',2006,7,'777.777.777-77');
INSERT INTO VEICULO VALUES ('JWB7196','VERDE',2007,1,'888.888.888-88');
INSERT INTO VEICULO VALUES ('HTG5629','AMARELO',2008,2,'999.999.999-99');
INSERT INTO VEICULO VALUES ('NAN8237','AZUL',2009,3,'111.111.111-11');
INSERT INTO VEICULO VALUES ('IAC2633','VERMELHO',2010,4,'222.222.222-22');
INSERT INTO VEICULO VALUES ('MAN0780','PRETO',2011,5,'333.333.333-33');
INSERT INTO VEICULO VALUES ('NEP8764','PRATA',2012,6,'444.444.444-44');
INSERT INTO VEICULO VALUES ('HZT9509','BRANCO',2013,7,'555.555.555-55');
INSERT INTO VEICULO VALUES ('NAR3855','VERDE',2014,1,'666.666.666-66');
INSERT INTO VEICULO VALUES ('IQC2616','AMARELO',2015,2,'777.777.777-77');
INSERT INTO VEICULO VALUES ('LVJ0030','AZUL',2016,3,'888.888.888-88');
INSERT INTO VEICULO VALUES ('NAD9982','VERMELHO',2017,4,'999.999.999-99');
INSERT INTO VEICULO VALUES ('MRZ7737','PRETO',2018,5,'111.111.111-11');
INSERT INTO VEICULO VALUES ('LNO2117','PRATA',2019,6,'222.222.222-22');
INSERT INTO VEICULO VALUES ('JEG6549','BRANCO',2020,7,'333.333.333-33');
INSERT INTO VEICULO VALUES ('JJJ-2020','BRANCO',2020,7,'333.333.333-33');
INSERT INTO VEICULO VALUES ('NEG9502','BRANCO',2020,7,'333.333.333-33');
SELECT * FROM VEICULO;

CREATE TABLE ESTACIONA(
	cod serial PRIMARY KEY,
	codPatio int,
	placa varchar(8),
	dtEntrada date,
	dtSaida date,
	hrEntrada time,
	hrSaida time,
	CONSTRAINT fk_codPatio FOREIGN KEY (codPatio) REFERENCES PATIO (codPatio),
	CONSTRAINT fk_placa FOREIGN KEY (placa) REFERENCES VEICULO (placa)
);
INSERT INTO ESTACIONA (codPatio, placa, dtEntrada, dtSaida, hrEntrada, hrSaida) VALUES (1, 'JJJ2J20', '2021-03-15', '2021-03-16', '08:00', '18:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (1,'JJJ2J20','2021-03-01','2021-03-01','08:00','09:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (2,'ABC1A11','2021-03-02','2021-03-02','09:00','10:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (3,'KBG9454','2021-03-03','2021-03-03','10:00','11:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (4,'KUV4063','2021-03-04','2021-03-04','11:00','12:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (5,'HRO9633','2021-03-05','2021-03-05','12:00','13:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (6,'HZU3858','2021-03-06','2021-03-06','13:00','14:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (7,'MOK1513','2021-03-07','2021-03-07','14:00','15:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (8,'JWB7196','2021-03-08','2021-03-08','15:00','16:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (9,'HTG5629','2021-03-09','2021-03-09','16:00','17:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (10,'NAN8237','2021-03-10','2021-03-10','17:00','18:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (11,'IAC2633','2021-03-11','2021-03-11','18:00','19:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (12,'MAN0780','2021-03-12','2021-03-12','19:00','20:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (1,'NEP8764','2021-03-13','2021-03-13','20:00','21:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (2,'HZT9509','2021-03-14','2021-03-14','21:00','22:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (3,'NAR3855','2021-03-15','2021-03-15','22:00','23:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (4,'IQC2616','2021-03-16','2021-03-16','23:00','00:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (5,'LVJ0030','2021-03-17','2021-03-17','00:00','01:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (6,'NAD9982','2021-03-18','2021-03-18','01:00','02:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (7,'MRZ7737','2021-03-19','2021-03-19','02:00','03:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (8,'LNO2117','2021-03-20','2021-03-20','03:00','04:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (9,'JEG6549','2021-03-21','2021-03-21','04:00','05:00');
INSERT INTO ESTACIONA(codpatio,placa,dtEntrada,dtSaida,hrEntrada,hrSaida) VALUES (9,'JJJ-2020','2021-03-21','2021-03-21','04:00','05:00');

--a) Exiba a placa e o nome dos donos de todos os veículos.
select 
	veiculo.placa,
	cliente.nome
from 
	veiculo  
	inner join cliente on veiculo.cpf = cliente.cpf; 

--b) Exiba o CPF e o nome do cliente que possui o veiculo de placa “JJJ2J20”.
select 
	cliente.nome,
	cliente.cpf,
	veiculo.placa
from 
	veiculo  
	inner join cliente on veiculo.cpf = cliente.cpf
WHERE
	veiculo.placa LIKE 'JJJ2J20';

--c) Exiba a placa e a cor do veículo que possui o código de estacionamento 1.
select 
	veiculo.placa,
	veiculo.cor,
	estaciona.codpatio,
	estaciona.dtentrada,
	estaciona.dtsaida
from 
	veiculo  
	inner join estaciona on veiculo.placa = estaciona.placa
WHERE
	estaciona.codpatio in (1);

--d) Exiba a placa e o ano do veículo que possui o código de estacionamento 3.
select 
	veiculo.placa,
	veiculo.ano,
	estaciona.codpatio	
from 
	veiculo  
	inner join estaciona on veiculo.placa = estaciona.placa
WHERE
	estaciona.codpatio in (3);

--e) Exiba a placa, o ano do veículo e a descrição de seu modelo, se ele possuir ano a partir de 2005.
select 
	veiculo.placa,
	veiculo.ano,
	modelo.descmodelo
from 
	veiculo  
	inner join modelo on veiculo.codmod = modelo.codmod
WHERE
	veiculo.ano BETWEEN 2005 and 2021;
	
--f) Exiba o endereço, a data de entrada e de saída dos estacionamentos do veículo de placa “JEG6549”.
SELECT	
	estaciona.codpatio,
	estaciona.placa,
	estaciona.dtentrada,
	estaciona.dtsaida	
from 
	estaciona  
	inner join patio on patio.codpatio = estaciona.codpatio
WHERE
	estaciona.placa LIKE 'JEG6549';

--g) Exiba a quantidade de vezes que os veículos de cor verde estacionaram.
select * from estaciona;
select * from modelo;
select * from patio;
select * from veiculo;

SELECT
	veiculo.cor,
	veiculo.placa,
	estaciona.cod
from
	estaciona
	inner join veiculo on estaciona.placa = veiculo.placa
group by
	veiculo.placa, estaciona.cod, veiculo.cor;


--h) Liste todos os clientes que possuem carro de modelo Corololla.


--i) Liste as placas, os horários de entrada e saída dos veículos de cor verde.


--j) Liste todos os estacionamentos do veículo de placa “JJJ-2020”.


--k) Exiba a descrição do modelo do veículo cujo código do estacionamento é 12.

	
--l) Exiba o CPF do cliente que possui o veículo que já estacionaram no pátio 3.


--m) Exiba os nomes dos clientes e o modelo do veículo dos veículos que estão estacionados no pátio 2.

--n) Exiba a placa, o nome dos donos e a descrição dos modelos e quantas vezes utilizou o estacionamento, de todos os veículos inclusive dos que nunca utilizaram o estacionamento.

	v.placa,
	c.nome,	
	m.descmodelo
