drop schema public cascade;
create schema public;

/*TELEFONE*/
CREATE TABLE TELEFONE(
	telefone_pk varchar(30) PRIMARY KEY,
	telefone varchar(30)
);

INSERT INTO TELEFONE VALUES ('1', '11111-1111'), 
							('2', '22222-2222');
SELECT * FROM TELEFONE;



/*SHOPPING*/
CREATE TABLE SHOPPING(
	nome varchar(50),
	cnpj bigint PRIMARY KEY,
	telefone_pk varchar(30) REFERENCES telefone(telefone_pk)
);
--ALTER TABLE SHOPPING ADD CONSTRAINT fk_TELEFONE_telefone_pk FOREIGN KEY (telefone_pk) REFERENCES TELEFONE(telefone_pk);

INSERT INTO SHOPPING VALUES ('Porto Velho Shopping', '11111111111111', '1'),
							('Iguatemi Shopping', '22222222222222', '2');
SELECT * FROM shopping;




/*ENDERECO*/
--DROP TABLE ENDERECO;
CREATE TABLE ENDERECO(
	rua varchar(20),
	numero int,
	logradouro varchar(20),
	bairro varchar(20),
	cidade varchar(20),
	estado varchar(20),
	pais varchar(20),
	latitude bigint,
	longitude bigint,
	PRIMARY KEY (latitude, longitude)
);

ALTER TABLE ENDERECO ALTER COLUMN latitude TYPE double precision;
ALTER TABLE ENDERECO ALTER COLUMN longitude TYPE double precision;

INSERT INTO endereco VALUES ('RUA XXX', 123, 'AVENIDA', 'ALGUM LUGAR', 'CIDADE DE DEUS', 'BRASILIA', 'BRASIL', -9.926463188169107, -62.96358110598489),
							('RUA YYY', 456, 'CENTRO', 'ZONA RURAL', 'ARIQUEMES', 'RONDONIA', 'BRASIL', -9.94975429205811, -62.96237116657146);
SELECT * FROM ENDERECO;



/*SHOPING_X_ENDERECO*/
CREATE TABLE SHOPPING_X_ENDERECO(
	fk_SHOPPING_cnpj bigint references shopping(cnpj),
	fk_ENDERECO_latitude double precision,
	fk_ENDERECO_longitude double precision,
	CONSTRAINT ENDERECO_laitute_longitude_fk FOREIGN KEY (fk_ENDERECO_latitude, fk_ENDERECO_longitude) REFERENCES endereco(latitude, longitude),
	PRIMARY KEY (fk_SHOPPING_cnpj, fk_ENDERECO_latitude, fk_ENDERECO_longitude)
);

INSERT INTO SHOPPING_X_ENDERECO VALUES (11111111111111, -9.94975429205811, -62.96237116657146),
									(22222222222222, -9.926463188169107, -62.96358110598489);

SELECT * FROM SHOPPING_X_ENDERECO;



/*HORARIO_FUNCIONAMENTO*/
--DROP TABLE HORARIOFUNCIONAMENTO;
CREATE TABLE HORARIOFUNCIONAMENTO (
	diaSemana varchar(16) PRIMARY KEY,
	horaInicial time,
	horaFinal time	
);
INSERT INTO HORARIOFUNCIONAMENTO VALUES ('SEGUNDA', '10:00', '22:00'),
										('TERCA', '10:00', '22:00'),
										('QUARTA', '10:00', '22:00'),
										('QUINTA', '10:00', '22:00'),
										('SEXTA', '10:00', '22:00'),
										('SABADO', '10:00', '22:00'),
										('DOMINGO', '10:00', '22:00');
SELECT * FROM HORARIOFUNCIONAMENTO;



/*SHOPING_X_HORARIOFUNCIONAMENTO*/
CREATE TABLE SHOPPING_X_HORARIOFUNCIONAMENTO(
	fk_SHOPPING_cnpj bigint references shopping(cnpj),
	fk_HORARIOFUNCIONAMENTO_diaSemana varchar(16) REFERENCES HORARIOFUNCIONAMENTO(diaSemana),
	PRIMARY KEY (fk_SHOPPING_cnpj, fk_HORARIOFUNCIONAMENTO_diaSemana)
);
INSERT INTO SHOPPING_X_HORARIOFUNCIONAMENTO VALUES (11111111111111, 'SEGUNDA'),
												  (11111111111111, 'TERCA'),
												  (11111111111111, 'QUARTA'),
												  (11111111111111, 'QUINTA'),
												  (11111111111111, 'SEXTA'),
												  (11111111111111, 'SABADO'),
												  (11111111111111, 'DOMINGO');

/*ESTABELECIMENTO*/
CREATE TABLE ESTABELECIMENTO(
	cnpj bigint PRIMARY KEY,
	nome varchar(50),
	numero int,
	descricao varchar(250),
	tempopreparo time
);

INSERT INTO ESTABELECIMENTO VALUES (33333333333333, 'ESTABELECIMENTO A', 321, 'LOJA A', '0:10'),
								   (44444444444444, 'ESTABELECIMENTO B', 321, 'LOJA B', '0:10'),
								   (55555555555555, 'ESTABELECIMENTO C', 321, 'LOJA C', '0:10'),
								   (66666666666666, 'ESTABELECIMENTO D', 321, 'LOJA D', '0:10');


CREATE TABLE ESTABELECIMENTO_X_SHOPPING(
	fk_SHOPPING_cnpj bigint references shopping(cnpj),
	fk_ESTABELECIMENTO_cnpj bigint references ESTABELECIMENTO(cnpj),
	PRIMARY KEY (fk_SHOPPING_cnpj, fk_ESTABELECIMENTO_cnpj)
);
INSERT INTO ESTABELECIMENTO_X_SHOPPING VALUES (11111111111111, 33333333333333),
											  (11111111111111, 44444444444444),
											  (22222222222222, 55555555555555),
											  (22222222222222, 66666666666666);

CREATE TABLE ESTABELECIMENTO_X_HORARIOFUNCIONAMENTO(
	fk_ESTABELECIMENTO_cnpj bigint references ESTABELECIMENTO(cnpj),
	fk_HORARIOFUNCIONAMENTO_diaSemana varchar(16) REFERENCES HORARIOFUNCIONAMENTO(diaSemana),
	PRIMARY KEY (fk_ESTABELECIMENTO_cnpj, fk_HORARIOFUNCIONAMENTO_diaSemana)
);
INSERT INTO ESTABELECIMENTO_X_HORARIOFUNCIONAMENTO VALUES (33333333333333, 'SEGUNDA'),
												  		  (44444444444444, 'TERCA'),
														  (55555555555555, 'QUARTA'),
														  (66666666666666, 'QUINTA'),
														  (33333333333333, 'SEXTA'),
														  (44444444444444, 'SABADO'),
														  (55555555555555, 'DOMINGO');

CREATE TABLE CATEGORIAESTABELECIMENTO(
	id int PRIMARY KEY,
	descricao varchar(200)
);
INSERT INTO CATEGORIAESTABELECIMENTO VALUES (1, 'BARES'),
											(2, 'RESTAURANTES'),
											(3, 'LANCHONETES'),
											(4, 'PIZZARIAS');

CREATE TABLE CATEGORIA_X_ESTABELECIMENTO(
	FK_ESTABELECIMENTO_cnpj bigint,
	fk_CATEGORIAESTABELECIMENTO_id int,
	PRIMARY KEY(FK_ESTABELECIMENTO_cnpj, fk_CATEGORIAESTABELECIMENTO_id)
);
INSERT INTO CATEGORIA_X_ESTABELECIMENTO VALUES (33333333333333, 1),
											   (44444444444444, 2);


--DROP TABLE ITEM;
CREATE TABLE ITEM(
	id bigint PRIMARY KEY,
	titulo varchar(50),
	descricao varchar(200),
	valor money
);
INSERT INTO ITEM VALUES (1, 'BATATA FRITA', 'BATATA CROCANTE TIPO DO MACDONALDS', 15.00),
						(2, 'PIZZA FAMILIA', 'PIZZA COM 12 PEDACOS', 65.50),
						(3, 'SORVETE', 'SORVETE DE CREME', 7.25);


CREATE TYPE statusObrigatorio as enum('S', 'N'); 
CREATE TABLE CATEGORIAITEM(
	id bigint PRIMARY KEY,
	titulo varchar(50),
	descricao varchar(200),
	statusObrigatorio statusObrigatorio	
);
INSERT INTO CATEGORIAITEM VALUES (1, 'LANCHES', 'LANCHES VARIADOS', 'S'),
								 (2, 'ACOMPANHAMENTOS', 'DIVERSOS', 'N'),
								 (3, 'PIZZAS', 'PIZZAS DIVERSAS', 'S'),
								 (4, 'SORVETES', 'SORVETES DIVERSOS', 'N');

CREATE TABLE ITEM_X_CATEGORIA(
	fk_ITEM_id bigint REFERENCES ITEM(id),
	fk_CATEGORIAITEM_id bigint REFERENCES CATEGORIAITEM(id),
	PRIMARY KEY(fk_ITEM_id, fk_CATEGORIAITEM_id)
);
INSERT INTO ITEM_X_CATEGORIA VALUES (1, 2), (2,3), (3,4);


CREATE TABLE ITEMCARDAPIO (
	id bigint PRIMARY KEY,
	nome varchar(50),
	descricao varchar(200),
	valor float,
	observacao varchar(100)	
);
INSERT INTO ITEMCARDAPIO VALUES (1, 'BATATA FRITA', 'BATATA CROCANTE TIPO DO MACDONALDS', 15.00, 'ESTOU COM FOME'),
								(2, 'PIZZA FAMILIA', 'PIZZA COM 12 PEDACOS', 65.50, 'ESTOU COM PRESSA'),
								(3, 'SORVETE', 'SORVETE DE CREME', 7.25, 'NAO DEMORE');

CREATE TABLE ITEMCARDAPIO_X_CATEGORIAITEM (
	fk_ITEMCARDAPIO_id bigint REFERENCES ITEMCARDAPIO(ID),
	fk_CATEGORIAITEM_id bigint REFERENCES CATEGORIAITEM(ID),
	PRIMARY KEY (fk_ITEMCARDAPIO_id, fk_CATEGORIAITEM_id)
);
INSERT INTO ITEMCARDAPIO_X_CATEGORIAITEM VALUES (1,1), (2,2), (3,3);

CREATE TABLE CARDAPIO (
	id bigint PRIMARY KEY,
	numero int,
	descricao varchar(200)
);
INSERT INTO CARDAPIO VALUES (1, 1, 'CARDAPIO A'), (2, 2, 'CARDAPIO B'), (3, 3, 'CARDAPIO C');

CREATE TABLE ESTABELECIMENTO_X_CARDAPIO (
	fk_ESTABELECIMENTO_cnpj bigint REFERENCES ESTABELECIMENTO(cnpj),
	fk_CARDAPIO_id bigint REFERENCES CARDAPIO(id),
	PRIMARY KEY(fk_ESTABELECIMENTO_cnpj, fk_CARDAPIO_id)
);
INSERT INTO ESTABELECIMENTO_X_CARDAPIO VALUES (33333333333333, 1), (44444444444444,2);

CREATE TABLE CATEGORIACARDAPIO(
	id bigint PRIMARY KEY,
	descricao varchar(200)
);
INSERT INTO CATEGORIACARDAPIO VALUES (1, 'ENTRADAS'), (2, 'PRATOS FEITOS'), (3, 'BEBIDAS');

CREATE TABLE CARDAPIO_X_CATEGORIACARDAPIO(
	fk_CARDAPIO_id bigint REFERENCES CARDAPIO(id),
	fk_CATEGORIACARDAPIO_id bigint REFERENCES CATEGORIACARDAPIO(id),
	PRIMARY KEY (fk_CARDAPIO_id, fk_CATEGORIACARDAPIO_id)
);
INSERT INTO CARDAPIO_X_CATEGORIACARDAPIO VALUES (1,1), (2,2), (3,3);

CREATE TABLE CATEGORIACARDAPIO_X_ITEMCARDAPIO(
	fk_CATEGORIACARDAPIO_id bigint REFERENCES CATEGORIACARDAPIO(id),
	fk_ITEMCARDAPIO_id bigint REFERENCES ITEMCARDAPIO(id),
	PRIMARY KEY(fk_CATEGORIACARDAPIO_id, fk_ITEMCARDAPIO_id)
);
INSERT INTO CATEGORIACARDAPIO_X_ITEMCARDAPIO VALUES (1,1), (2,2), (1,3);

CREATE TABLE USUARIO(
	nome varchar(50),
	email varchar(50) PRIMARY KEY,
	senha varchar(20)
);
INSERT INTO USUARIO VALUES ('Adriano', 'adriano@gmail.com', 'xxxx'), ('Geisy', 'geisy@gmail.com', 'yyyy');


CREATE TABLE CARTAO(
	numero bigint PRIMARY KEY,
	cpfcnpj bigint,
	validade date,
	cvv int,
	nometitular varchar(50),
	fk_usuario_email varchar(50) REFERENCES USUARIO(email)
);
INSERT INTO CARTAO VALUES (123456789, 987654321, '2022-06-22', 159, 'ADRIANO', 'adriano@gmail.com');


CREATE TYPE fpagamento as enum('Debito', 'Credito');
CREATE TABLE AVALIACAO_PEDIDO(
	id bigint PRIMARY KEY,
	nota varchar(200),
	descricao varchar(200),
	datahora timestamp,
	numero int,
	horarealizacao time,
	formaPagamento fpagamento,
	fk_usuario_email varchar(50)	
);
INSERT INTO AVALIACAO_PEDIDO VALUES (1, 'PRODUTO CHEGOU MUITO FRIU','XASXASXASXAS', '2021-06-22 18:00', 200, '18:01', 'Debito', 'adriano@gmail.com' ),
									--(2, '', '', now(), 201, CURRENT_TIME, 'Credito', 'geisy@gmail.com'),
									(2, '', '', '2021-06-23 18:00', 201, CURRENT_TIME, 'Credito', 'geisy@gmail.com'),
									(3, '', '', now(), 202, CURRENT_TIME, 'Debito', 'adriano@gmail.com');


CREATE TABLE AVALIACAO_PEDIDO_X_ESTABELECIMENTO (
	fk_pedido_id bigint REFERENCES AVALIACAO_PEDIDO(id),
	fk_ESTABELECIMENTO_cnpj bigint REFERENCES ESTABELECIMENTO(cnpj),
	PRIMARY KEY (fk_pedido_id, fk_ESTABELECIMENTO_cnpj)
);
INSERT INTO AVALIACAO_PEDIDO_X_ESTABELECIMENTO VALUES (1,33333333333333), (2,33333333333333), (3,33333333333333);
/*pra mim a o estabelecimento teria que ficar dentro pedido.... pois nao existe pedido sem estabelecimento... */


CREATE TABLE STATUSPEDIDO(
	id int PRIMARY KEY,
	descricao varchar(200)
);
INSERT INTO STATUSPEDIDO VALUES (1, 'EM PRODUCAO'), (2, 'A CAMINHO'), (3, 'ENTREGUE'), (4, 'EM ATRASO');


CREATE TABLE PEDIDO_X_STATUS(
	fk_pedido_id bigint REFERENCES AVALIACAO_PEDIDO(id),
	fk_statuspedido_id int REFERENCES STATUSPEDIDO(id),
	PRIMARY KEY (fk_statuspedido_id, fk_pedido_id)
);
INSERT INTO PEDIDO_X_STATUS VALUES (1,3), (2,1), (3,2);


CREATE TABLE USUARIO_X_AVALIACAO_PEDIDO(
	fk_usuario_email varchar(50) REFERENCES USUARIO(email),
	fk_pedido_id bigint REFERENCES AVALIACAO_PEDIDO(id),
	PRIMARY KEY (fk_usuario_email, fk_pedido_id)
);
INSERT INTO USUARIO_X_AVALIACAO_PEDIDO VALUES ('adriano@gmail.com',1), ('geisy@gmail.com', 2), ('adriano@gmail.com',3);

CREATE TABLE AVALIACAO_PEDIDO_X_ITEMCARDAPIO(
	fk_pedido_id bigint REFERENCES AVALIACAO_PEDIDO(id),
	fk_ITEMCARDAPIO_id bigint REFERENCES ITEMCARDAPIO(id),
	PRIMARY KEY(fk_pedido_id, fk_ITEMCARDAPIO_id)	
);
INSERT INTO AVALIACAO_PEDIDO_X_ITEMCARDAPIO VALUES (1, 1), (1,2), (1,3),
													(2,1),
													(3,2);
/*********************************************/
/*********************************************/
/*         EXECUCAO DAS ATIVIDADES           */
/*********************************************/
/*********************************************/

				/**************************************/
				/*         VIEW cardapio              */
				/*************************************/
create or replace view V_cardapio as
	select 
		card.id as "Codigo",
		cat_card.descricao as "Categoria",
		itcar.nome as "Produto",
		itcar.valor as "Preço"
	from	
		cardapio card
		inner join cardapio_x_categoriacardapio card_x_cat on card.id = card_x_cat.fk_cardapio_id 
		inner join categoriacardapio cat_card on card_x_cat.fk_categoriacardapio_id = cat_card.id  
		inner join categoriacardapio_x_itemcardapio cat_x_itcar on cat_card.id = cat_x_itcar.fk_itemcardapio_id
		inner join itemcardapio itcar on cat_x_itcar.fk_itemcardapio_id = itcar.id;
	
	select * from V_cardapio;	
		


/*********************************************/
/*        VIEW DETALHES DO PEDIDO            */
/*********************************************/
create or replace view V_detalhes_pedido as
SELECT
	e.nome empresa,
	p.id pedido,
	p.datahora data_pedido,
	u.nome cliente,
	ic.nome produto,
	ic.valor
	
FROM
	AVALIACAO_PEDIDO p
	INNER JOIN USUARIO u on p.fk_usuario_email = u.email
	INNER JOIN AVALIACAO_PEDIDO_X_ITEMCARDAPIO ap on p.id = ap.fk_pedido_id
	INNER JOIN ITEMCARDAPIO ic on ap.fk_ITEMCARDAPIO_id = ic.id
	INNER JOIN AVALIACAO_PEDIDO_X_ESTABELECIMENTO pe on p.id = pe.fk_pedido_id
	INNER JOIN ESTABELECIMENTO e on pe.fk_ESTABELECIMENTO_cnpj = e.cnpj;
select * from V_detalhes_pedido;


                /**************************************/
				/*    VIEW endereco_estacionamento    */
				/**************************************/
create or replace view V_endereco_estacionamento as
	select 
		est.nome as "Estacionamento",
		shop.nome as "shopping",
		hfun.diasemana as "Dia da semana",
		hfun.horainicial as "Horario de abertura",
		hfun.horafinal as "Horario de fechamento",
		ende.rua as "Rua",
		ende.bairro as "Bairro",
		ende.cidade as "Cidade",
		ende.estado as "Estado"
		
		
	from	
		estabelecimento est
		inner join estabelecimento_x_shopping est_x_shop on est.cnpj = est_x_shop.fk_estabelecimento_cnpj 
		inner join shopping shop on est_x_shop.fk_shopping_cnpj = shop.cnpj  
		inner join shopping_x_horariofuncionamento shop_hfun on shop.cnpj = shop_hfun.fk_shopping_cnpj
		inner join horariofuncionamento hfun on shop_hfun.fk_horariofuncionamento_diasemana = hfun.diasemana
		inner join shopping_x_endereco shop_x_end on shop.cnpj = shop_x_end.fk_shopping_cnpj
		inner join endereco ende on shop_x_end.fk_endereco_latitude = ende.latitude;   	 	 
		
	
	select * from V_endereco_estacionamento;		


/*********************************************/
/*       FUNCTION VALOR TOTAL PEDIDO         */
/*********************************************/
create or replace function F_total_pedido (p_pedido_id bigint, p_estabelecimento_cnpj bigint) returns float 
as $$
declare
	resultado float := 0.0;
begin
	SELECT
		sum(ic.valor) into resultado 
	FROM
		AVALIACAO_PEDIDO_X_ITEMCARDAPIO ap 
		INNER JOIN ITEMCARDAPIO ic on ap.fk_ITEMCARDAPIO_id = ic.id
		INNER JOIN AVALIACAO_PEDIDO_X_ESTABELECIMENTO pe on ap.fk_pedido_id = pe.fk_pedido_id
		INNER JOIN ESTABELECIMENTO e on pe.fk_ESTABELECIMENTO_cnpj = e.cnpj
	WHERE 
		ap.fk_pedido_id = p_pedido_id
		and e.cnpj = p_estabelecimento_cnpj;
		
	if (resultado is null) then
		resultado = 0.0;
	end if;
	
	return resultado;
end;
$$ language plpgsql;



/*********************************************/
/*       FUNCTION QTDE PEDIDOS POR DATA      */
/*********************************************/
create or replace function F_qtde_pedidos (p_data date, p_cnpj bigint) returns integer 
as $$
declare
	resultado integer := 0;
begin
	SELECT
		count(p.id) into resultado 
	FROM
		AVALIACAO_PEDIDO p
		INNER JOIN AVALIACAO_PEDIDO_X_ESTABELECIMENTO pe on p.id = pe.fk_pedido_id
		INNER JOIN ESTABELECIMENTO e on pe.fk_ESTABELECIMENTO_cnpj = e.cnpj
	WHERE
		p.datahora::date = p_data
		and e.cnpj = p_cnpj;
	
	return resultado;
end;
$$ language plpgsql;


/*********************************************/
/*  VIEW VENDA EMPRESA X DATA X QTDE PEDIDOS */
/*********************************************/
create or replace view V_vendas_data_qtde as
SELECT
	e.nome empresa,
	p.datahora ::timestamp::date data_venda,
	F_qtde_pedidos(p.datahora ::timestamp::date, e.cnpj) qtde_pedidos,
	sum(F_total_pedido(p.id,e.cnpj)) valor
	
FROM
	AVALIACAO_PEDIDO p
	INNER JOIN USUARIO u on p.fk_usuario_email = u.email
	INNER JOIN AVALIACAO_PEDIDO_X_ESTABELECIMENTO pe on p.id = pe.fk_pedido_id
	INNER JOIN ESTABELECIMENTO e on pe.fk_ESTABELECIMENTO_cnpj = e.cnpj
GROUP BY
	e.nome,
	p.datahora,
	F_qtde_pedidos(p.datahora ::timestamp::date, e.cnpj)
	
ORDER BY
	p.datahora;
	

/*********************************************/
/*       FUNCTION HORARIO FUNCIONAMENTO      */
/*********************************************/
create or replace function F_horario_shopping (p_shopping_cnpj bigint, p_horario_funcionamento varchar(16)) returns boolean 
as $$
declare
	pesquisa INT := 0;
	resultado boolean := TRUE;
begin
	SELECT
		 1 into pesquisa 
	FROM
		SHOPPING_X_HORARIOFUNCIONAMENTO sf
	WHERE
		fk_SHOPPING_cnpj =  p_shopping_cnpj
		and fk_HORARIOFUNCIONAMENTO_diaSemana = p_horario_funcionamento;
	
	if (pesquisa is null) then
		resultado = FALSE;
	end if;
	
	return resultado;
end;
$$ language plpgsql;

