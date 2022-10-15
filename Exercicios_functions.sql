--1. Crie	um	banco	de	dados	chamado	exercício_functions;

--2. Crie	as	tabelas	conforme	o	modelo	ER	abaixo: 
--3. Registre	algumas	informações	aleatórias	no	banco,	para	exemplo;

CREATE TABLE Tipo(
	cod_tipo serial primary key,
	nome varchar(50)
);

select * from tipo;

INSERT INTO Tipo(nome) VALUES ('Televisão');
INSERT INTO Tipo(nome) VALUES ('Radio');
INSERT INTO Tipo(nome) VALUES ('Calça');
INSERT INTO Tipo(nome) VALUES ('Tenis');
INSERT INTO Tipo(nome) VALUES ('Mesa');
INSERT INTO Tipo(nome) VALUES ('Bateria de carro');
INSERT INTO Tipo(nome) VALUES ('Computador');
INSERT INTO Tipo(nome) VALUES ('Cadeira');
INSERT INTO Tipo(nome) VALUES ('Teclado');


CREATE TABLE Produto(
	cod_prod serial primary key,
	preco decimal (10,2),
	estoque int,
	cod_tipo_fk int,
	FOREIGN KEY (cod_tipo_FK) REFERENCES Tipo(cod_tipo)
);

SELECT * FROM PRODUTO;

INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('1200.', '20','1');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('250.', '100','2');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('120.', '80','3');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('400.50', '60','4');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('680.', '5','5');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('450.80', '15','6');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('3800.90', '2','7');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('830.37', '8','8');
INSERT INTO Produto(preco, estoque, cod_tipo_fk) VALUES ('99.99', '33','9');


CREATE TABLE Usuario(
	cod_usu serial primary key,
	nome varchar(45)
);

select * from usuario;

INSERT INTO Usuario(nome) VALUES ('João da Silva');
INSERT INTO Usuario(nome) VALUES ('Bento Oliveira');
INSERT INTO Usuario(nome) VALUES ('Chaves Chavier');
INSERT INTO Usuario(nome) VALUES ('Amanda Alves');
INSERT INTO Usuario(nome) VALUES ('Hugo Pereira ');
INSERT INTO Usuario(nome) VALUES ('Sergio Santos');
INSERT INTO Usuario(nome) VALUES ('Paola Oliveira Bernado');
INSERT INTO Usuario(nome) VALUES ('Ka Ka');
INSERT INTO Usuario(nome) VALUES ('Paula Brito');


CREATE TABLE Venda(
	cod_vend serial primary key,
	quantidade int,
	cod_usu_fk INT,
	cod_prod_fk INT,
	FOREIGN KEY (cod_usu_fk) references usuario(cod_usu),
	FOREIGN KEY (cod_prod_fk) references produto(cod_prod)
);

select * from venda;

INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('2', '1','1');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('5', '2','2');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('3', '3','3');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('1', '4','4');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('1', '5','5');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('8', '6','6');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('6', '7','7');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('3', '8','8');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('4', '9','9');
INSERT INTO Venda(quantidade, cod_usu_fk, cod_prod_fk) VALUES ('4', '1','1');


--4. Crie	uma	function	que	receba	o	código	do	produto	e	ela	retorne	a	
--quantidade	de	estoque;

create or replace function quantidade_estoque (valor int) returns integer
AS $$
declare
	quant integer := 0;
begin
	select estoque into quant from produto 
	where cod_prod = valor;
	return quant;
end;	
$$ language plpgsql;

select quantidade_estoque(1);
select * from produto;


--5. Crie	uma	function	que	receba	o	código	do	produto	e	retorne	o	nome	
--do	tipo	do	mesmo;

create or replace function nome_tipo (cod int) returns text
AS $$
declare
	nome varchar(40);
begin
	select tipo.nome into nome from 
	tipo
	inner join
	produto on cod_tipo_fk = cod_tipo
	where
	produto.cod_prod = cod;
	return nome;
end;	
$$ language plpgsql;

select nome_tipo(1);
select * from produto;
select * from tipo;


--6. Crie	uma	function	que	receba	o	código	do	produto	e	mostre	o	resultado	
--da	equação	Preço	x	Estoque;

create or replace function preco_estoque (valor int) returns float
AS $$
declare
	resul float;
begin
	select preco * estoque into resul from produto
	where cod_prod = valor;
	return resul;
end;	
$$ language plpgsql;

select preco_estoque(1);
select * from produto;


--7. Crie uma	function	que	receba	o	código	da	venda	e	mostre	a	quantidade	vendida;

create or replace function quantidade_vendida (valor int) returns integer
AS $$
declare
	quant_venda integer := 0;
begin
	select quantidade into quant_venda from venda
	where cod_vend = valor;
	return quant_venda;
end;	
$$ language plpgsql;

select quantidade_vendida(2);
select * from venda;


--8. Crie	uma	function	que	receba	o	código	da	venda	e	mostre	a	quantidade	
--vendida	x	preço	do	produto;

create or replace function quat_preco_vend (valor int) returns float
AS $$
declare
	resul float;
begin
	select venda.quantidade * produto.preco into resul from 
	venda
	inner join
	produto on cod_prod_fk = cod_prod
	where cod_vend = valor;
	return resul;
end;	
$$ language plpgsql;

select quat_preco_vend(1);
select * from produto;
select * from venda;


--9. Crie	uma	function	que	receba	o	código	do	usuário	e	mostre	quantos	produtos	
--ele	já	comprou;

create or replace function produto_comprado (valor int) returns int
AS $$
declare
	quant int := 0;
begin
	select sum(venda.quantidade) into quant from 
	usuario
	inner join
	venda on cod_usu_fk = cod_usu
	where cod_usu_fk = valor;
	return quant;
end;	
$$ language plpgsql;

select produto_comprado(1);
select * from venda;
select * from usuario;


--10.Crie	uma	function	que	receba	o	código	do	produto	e	mostre	a	média	da	
--quantidade	vendida;

create or replace function media_vendida (valor int) returns float
AS $$
declare
	quant float;
begin
	select avg(venda.quantidade) into quant from 
	produto
	inner join
	venda on cod_prod_fk = cod_prod
	where cod_prod = valor;
	return quant;
end;	
$$ language plpgsql;

select media_vendida(1);
select * from venda;
select * from produto;







