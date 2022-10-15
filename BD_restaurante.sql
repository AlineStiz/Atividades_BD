----------------------------------------------
CREATE TABLE Cargo (Cd_Cargo    INT           IDENTITY  PRIMARY KEY,
					  Descricao   VARCHAR(30)   NOT NULL);
----------------------------------------------
CREATE TABLE Funcionario (Matricula     INT           IDENTITY(1000, 1)         PRIMARY KEY,
						    Cd_Cargo      INT           REFERENCES Cargo(Cd_Cargo) NOT NULL,
						    Nome		  VARCHAR(80)	NOT NULL,
						    Logradouro    VARCHAR(100)	NOT NULL,
       					    Numero	      VARCHAR(10)	NOT NULL,
						    Complemento   VARCHAR(100),
						    CEP		      CHAR(9)		NOT NULL,
						    Bairro	      VARCHAR(30)	NOT NULL,
						    Cidade        VARCHAR(30)	NOT NULL,
						    Estado	      CHAR(2)		NOT NULL,
						    Telefone      VARCHAR(18)	NOT NULL,
						    Email		  VARCHAR(80)	NOT NULL                  UNIQUE);
------------------------------------------------------------------------------------------
CREATE TABLE Conta (Nr_Conta		    INT		IDENTITY(1,1)	PRIMARY KEY,
					  Matricula		    INT		REFERENCES Funcionario(Matricula) NOT NULL,
					  Hora_Abertura	    TIME	NOT NULL,
					  Data_Abertura	    DATE	NOT NULL,
					  Hora_Fechamento	TIME,
					  Data_Fechamento	DATE);
-----------------------------------------------------------------------
CREATE TABLE Pagamento (Nr_Pagamento	INT			    IDENTITY(1,1)	           PRIMARY KEY,
						  Nr_Conta		INT			    REFERENCES Conta(Nr_Conta) NOT NULL,
						  Valor			DECIMAL(8,2)	NOT NULL, 
    					  Data			DATE			NOT NULL,
						  Hora			TIME			NOT NULL);
---------------------------------------------------------------------------------------------
CREATE TABLE Cartao (Nr_Cartao	    CHAR(16)			  PRIMARY KEY,
					   Nr_Pagamento     INT			  REFERENCES Pagamento(Nr_Pagamento) NOT NULL,
					   Nome			    VARCHAR(50)   NOT NULL,
					   Validade		    CHAR(5)		  NOT NULL,
					   Bandeira		    VARCHAR(20)   NOT NULL);
---------------------------------------------------------------------------------------------
CREATE TABLE Cheque (Nr_Cheque	INT			PRIMARY KEY,
					   Nr_Pagamento INT			REFERENCES Pagamento(Nr_Pagamento) NOT NULL,
					   Banco		VARCHAR(20) NOT NULL,
					   Agencia      CHAR(6)		NOT NULL,
					   Data		    DATE		NOT NULL );
---------------------------------------------------------------------------------------------
CREATE TABLE Mesa (Nr_Mesa		INT			IDENTITY(1,1) PRIMARY KEY,
				     Localizacao	CHAR(1)		NOT NULL	  CHECK(Localizacao = 'I' OR Localizacao = 'E') );
------------------------------------------------------------------------------------------------
CREATE TABLE Conta_Mesa (Nr_Conta		INT		REFERENCES		Conta(Nr_Conta) NOT NULL,
						   Nr_Mesa		INT		REFERENCES		Mesa(Nr_Mesa)   NOT NULL,	
						   PRIMARY KEY	(Nr_Conta, Nr_Mesa)	);
------------------------------------------------------------------------------------------------
CREATE TABLE Pedido (Nr_Pedido    INT    IDENTITY(1,1)            PRIMARY KEY,
                     Nr_Mesa      INT    REFERENCES Mesa(Nr_Mesa) NOT NULL,
                     Data         DATE   NOT NULL, 
					 Hora         TIME   NOT NULL );
------------------------------------------------------------------------------------------------
CREATE TABLE Cardapio (Nr_Cardapio INT IDENTITY(1,1) PRIMARY KEY,
                       Descricao   VARCHAR(50)       NOT NULL,
                       Preco       DECIMAL(6,2)      NOT NULL );
------------------------------------------------------------------------------------------------
CREATE TABLE Pedido_Cardapio (Nr_Pedido      INT    REFERENCES    Pedido(Nr_Pedido)     NOT NULL,
                              Nr_Cardapio    INT    REFERENCES    Cardapio(Nr_Cardapio) NOT NULL,    
                              PRIMARY KEY(Nr_Pedido, Nr_Cardapio),    
							    Preco          DECIMAL(6,2)         NOT NULL,
							    Quantidade     INT                  NOT NULL);                             
------------------------------------------------------------------------------------------------
CREATE TABLE Produto (Cd_Produto     INT          IDENTITY(1,1)  PRIMARY KEY,
					    Descricao      VARCHAR(50)	NOT NULL,
					    Estoque_Minimo INT			NOT NULL,
					    Estoque_Atual  INT			NOT NULL,
					    Preco_Custo    DECIMAL(6,2)	NOT NULL);
------------------------------------------------------------------------------------------------
CREATE TABLE Cardapio_Produto(Nr_Cardapio    INT   REFERENCES Cardapio(Nr_Cardapio) NOT NULL,
                              Cd_Produto     INT   REFERENCES Produto(Cd_Produto)   NOT NULL,							    
				    		    Quantidade     INT   NOT NULL,
			     			    Preco          DECIMAL(6,2));
------------------------------------------------------------------------------------------------
INSERT INTO Cargo (Descricao) 
 			 VALUES ('Gerente'),
			        ('Garçom'),
					('Cozinheiro'),
					('Faxineiro'),
					('Auxiliar de Cozinha'),
					('Bartender');
--------------------------------------------------------------------------------------------------
INSERT INTO Funcionario (Cd_Cargo,Nome,Logradouro, Numero,Complemento,CEP,Bairro,Cidade,Estado,Telefone,Email)
				 VALUES (2, 'João Alfredo Neto',         'Rua Joaquim Capixaba',          '177',  NULL,                  '55800-000',  'Cascata',           'Recife',               'PE', '(81)99345-2577',  'joaoalfredo177@gmail.com'),
						(1, 'Maria Francisca Silvana',   'Rua Tabelião Francisco Peixoto','102',  'Casa',                '55800-000',  'COHAB',             'Recife',               'PE', '(81)98467-2813',  'mariafrancisca102@gmail.com'),
						(4, 'Júlia Ferreira de Barros',  'Rua Rosa e Silva',              '69',   'Casa',                '54700-321',  'Boa Vista',         'Recife',               'PE', '(81)98612-6378',  'juliaferreira35@outlook.com'),
						(4, 'Maria de Fatima Bernadetes','Rua Palha Queimada',            '67',   NULL,                  '51158-821',  'Abreu e Lima',      'Paulista',             'PE', '(81)93437-6577',  'mfb.oficial@gmail.com'),
						(5, 'Zeferino Barbosa de Souza', 'Rua Serra Talhada',             '104',  'Quadra 73 - Bloco 04','52678-510',  'Arthur Lundgren II','Paulista',             'PE', '(81)99877-6542',  'severinoDelas101@gmail.com'), 
						(2, 'Frederico José da Slva ',   'Rua João de Barro',             '130',  'Casa',                '54759-195',  'Brasilandia',       'Recife',               'PE', '(81)99741-8972',  'frederico@gmail.com'),
                        (3, 'João da Silva Neves ',      'Rua Antonio da Silva',          '158',  'Apartamento',         '54759-165',  'Brasilandia',       'Recife',               'PE', '(81)99741-8973',  'joaodasilva123@gmail.com'),
						(3, 'Allana Martins Silva',      'Rua Bezerros',                  '75',   NULL,                  '54735-570',  'Centro' ,           'São Lourenço da Mata', 'PE', '(81)99468-1221',  'allanasilva@hotmail.com'),
						(6, 'Rodrigo Lisboa Melo',       'Rua Rogério Guedes',            '98',   'Apartamento',         '56898-000',  'Liberdade',         'Recife',               'PE', '(81)98642-9982',  'rodrigomelzinho@outlook.com'),
						(5, 'Júlia Mariana Lisboa',      'Rua Palha Queimada',            '72',   NULL,                  '54800-000',  'Matadouro',         'Moreno',               'PE', '(81)99766-3242',  'juliamarianalinda12@gmail.com'),
						(2, 'Jorge Henrique Lopes',      'Rua Salvador Dali',             '115A', 'Casa',                '54753-590',  'Santo Amaro',       'Recife',               'PE', '(81)98782-1880',  'jorginhoda12@gmail.com'),
						(6, 'Mariana Lima Mariano',      'Rua Silvano Ciprano',           '15B',  'Casa',                '57800-00',   'Nacional',          'São Lourenço da Mata', 'PE', '(81)97654-2341',  'marianalima1212@gmail.com');
------------------------------------------------------------------------------------------------ 
INSERT INTO Conta (Matricula,Hora_Abertura,Data_Abertura,Hora_Fechamento,Data_Fechamento) 
		   VALUES (1005, '16:26:30', '16/05/2020', '17:50:27', '16/05/2020'),
				  (1005, '12:32:11', '14/03/2020', '15:46:10', '14/03/2020'),
				  (1005, '10:30:00', '20/06/2020', '17:00:00', '20/06/2020'),
				  (1000, '23:05:11', '19/06/2020',    NULL,        NULL    ),
				  (1000, '12:20:56', '11/01/2020', '16:50:21', '11/01/2020'),
				  (1010, '20:05:11', '20/06/2020',    NULL,        NULL    ),
                  (1010, '21:10:55', '27/02/2020',    NULL,        NULL    );
------------------------------------------------------------------------------------------------
INSERT INTO MESA (Localizacao) 
			VALUES ('I'),('I'),('I'),('I'),('I'),
			       ('I'),('I'),('I'),('I'),('I'),
				   ('E'),('E'),('E'),('E'),('E'),
				   ('E'),('E'),('E'),('E'),('E');
------------------------------------------------------------------------------------------------
INSERT INTO Conta_Mesa (Nr_Conta,Nr_Mesa) 
                VALUES (1, 16),
						 (2,  3),
                       (3,  5),
						 (4, 14),
						 (5, 11),
						 (6,  8),
						 (7,  7);
------------------------------------------------------------------------------------------------
INSERT INTO Pagamento (Nr_Conta, Valor, Data, Hora) VALUES (1, 94.00, '16/05/2020', '17:50:33'),
															(2, 43.00, '14/03/2020', '15:46:15'),
															(3, 32.00, '20/06/2020', '17:00:03'),
															(5, 32.00, '11/01/2020', '16:50:25');
------------------------------------------------------------------------------------------------
INSERT INTO Cartao (Nr_Cartao, Nr_Pagamento, Nome, Validade, Bandeira)
			VALUES ('1122334455667788', 1, 'ARLINDO J CORREIOS', '03/25', 'MasterCard'),
				   ('9988776611223344', 3, 'JOSE ROMARIO SILVA', '05/24', 'Hipercard');
------------------------------------------------------------------------------------------------
INSERT INTO Cheque (Nr_Cheque, Nr_Pagamento, Banco, Agencia, Data)
			VALUES (123456, 2, 'Banco Santander', '9876-5', '14/03/2020');
------------------------------------------------------------------------------------------------
INSERT INTO Cardapio (Descricao,Preco) 
				VALUES ('Pizza de Calabresa - Grande',             38.00),
				       ('Pizza de Quatro Queijos - Grande',        36.00),
					   ('Pizza de Portuguesa - Pequena',           16.00),
					   ('Pizza de Calabresa - Média',              29.00),
					   ('Coca-Cola - 2L',                          12.00),
					   ('Coca-Cola - Lata',                        4.00),
					   ('Água - Garrafa',                          3.00),											  
					   ('Pure de Batata Cremoso - 300g ',          11.00),
					   ('Lasanha - Prato Pequeno',                 25.00),
					   ('Feijoada - Executivo',                    15.00),
					   ('Caldo de Piranha - Executivo',            18.00),
					   ('Delícia de Abacaxi - 300ml',              7.00),
					   ('Sorvete 500ml',                           8.00), 											  
					   ('Galeto -  Completo',					   24.00 ),
					   ('Carne de Sol - Completa',                 78.00),
					   ('Filé à Parmegiana - Completo',			   24.50 ),								
					   ('Strogonoff de Frango - Completo',         15.00),				  							
					   ('Frango à Milanesa - Completo',            20.00),
					   ('Carne com legumes chop suey - Executivo', 33.50),
					   ('Frango xadrez - Executivo',               34.50);
------------------------------------------------------------------------------------------------
INSERT INTO Pedido(Nr_Mesa,Hora,Data) 
			 VALUES (16, '16:26:30' , '2020-05-16'),
 				    (3,  '12:32:11' , '2020-03-14'),
					(5,  '10:30:00' , '2020-06-20'),
					(14, '23:05:11' , '2020-06-19'),
					(11, '12:20:56' , '2020-01-11'),
					(8,  '20:05:11' , '2020-06-20'),
					(7,  '21:10:55' , '2020-02-27');																 
------------------------------------------------------------------------------------------------
INSERT INTO Pedido_Cardapio (Nr_Pedido,Nr_Cardapio,Preco,Quantidade) 
					   VALUES (1, 4,  29.00, 2),
							  (1, 5,  12.00, 3),
    						  (2, 8,  11.00, 2),
					          (2, 10, 15.00, 1),
						      (2, 7,  3.00,  2),
							  (3, 14, 24.00, 1),
							  (3, 6,  4.00,  2),
							  (4, 16, 24.50, 2),
							  (4, 5,  12.00, 1),
							  (5, 11, 18.00, 1),
							  (5, 12, 7.00,  2),
							  (6, 18, 20.00, 1),
							  (6, 6,  4.00,  4),
							  (7, 13, 8.00,  3),
							  (7, 15, 78.00, 1),
						      (7, 5,  12.00, 1);
------------------------------------------------------------------------------------------------
INSERT INTO Produto(Descricao,Estoque_Minimo,Estoque_Atual,Preco_Custo)
			VALUES ('Feijão Preto',35,27,4.20),
				   ('Coca-Cola -2L',15,16,8.00),
				   ('Água - Garrafa',17,14,1.00),
				   ('Sorvete Napolitano',3,4,50.00),
				   ('Coca-Cola - Lata',20,21,2.20),
    			   ('Macarrão', 5 , 90, 5.90),
				   ('Presunto', 3 , 6 , 10.20),
				   ('Caldo de Piranha',12,17,13.00),
				   ('Milho - Lata',14,22,2.00),
				   ('Peito de Frango',30,35,9.0), 
				   ('Farinha',15,20,4.00),
				   ('Trigo',20,35,4.50),
				   ('Creme de  leite',18,20,3.50),
				   ('Leite',22,23,4.00),
				   ('Calabresa', 50, 20, 5.75),
				   ('Mussarela', 30, 45, 10.87),
				   ('Catupiry', 32,36, 9.28),
				   ('Batata',27,32,5.55),
				   ('Delicia de Abacaxi',2,2,75.50),
				   ('Carvão - Saco',6,7,5.55),
				   ('Feijão',42,45,5.20),
				   ('Ervilha - Lata',26,28,3.25),
				   ('Cenoura',15,16,4.50),
				   ('Cheedar',13,14,12.00),
				   ('Repolho',17,5,5.00),
				   ('Coentro',20,22,6.65),
				   ('Carne de Sol',30,20,25.55),
				   ('Queijo Coalho',42,42,22.00),
				   ('Sazon - Caixa',3,4,15.00),
				   ('Arroz Branco',32,35,3.25),
				   ('Bacon',12,14,15.00),
				   ('Charque',23,27,25.00),
				   ('Shoyu - Garrafa',6,11,7.75);
------------------------------------------------------------------------------------------------
 INSERT INTO Cardapio_Produto (Nr_Cardapio, Cd_Produto, Quantidade, Preco) 
					      VALUES (4, 12, 1, 4.50),
								 (4, 15, 1, 5.75),
								 (4, 16, 1, 5.50),
								 (4, 9, 1, 2.00),
								 (5, 2, 1, 8.00), 
								 --pedido2
								 (10, 1, 1, 2.60),
							 	 (10, 32, 1, 6.50),
							     (10, 30, 1, 2.20),
								 (10, 15, 1, 2.50),
								 (7, 3, 1, 1.00),
								 (8, 18, 1, 5.55),
								 (8, 13, 1, 3.00),
								 (8, 14, 1, 2.00),
								 --pedido 3
								 (6,2,1,8.00),
								 (14,1,1,4.20),
								 (14,11,1,2.00),
								 (14,18,1,2.00),
								 (14,30,1,1.50),
								 --pedido 4
								 (5,2,1,8.00),								
								 (16,10,1,9.50),
								 (16,9,1,0.50),
								 (16,30,1,3.25),
								 (16,1,1,2.65),
								--pedido 5
								 (11, 8, 1, 13.00),
							 	 (11, 30, 1, 2.20),
								 (11, 21, 1, 2.00),
								 (12, 19, 1, 2.30),
								 --pedido 6
								 (18,18,1,5.50),
								 (18,9,1,2.00),
								 (18,28,1,3.30),
								 (18,1,1,4.20),
								 (18,30,1,3.25),
							     (6,5,1,2.20),
								 --pedido 7
								 (5,6,1,4.00),
								 (13,4,1,2.50),
								 (15,21,1,2.30),
								 (15,30,1,3.25),
								 (15,31,1,4.00);
------------------------------------------------------------------------------------------------
-----------------------------------PROGRAMAÇÃO--------------------------------------------------
------------------------------------------------------------------------------------------------
--Desenvolva um trigger capaz de deduzir do estoque_atual dos produtos, a quantidade referente ao prato que foi solicitado

CREATE TRIGGER Debitar_estoque ON Pedido_Cardapio
FOR INSERT
AS BEGIN
	UPDATE Produto
	SET Estoque_Atual = (Estoque_Atual - (ItemPedido.Quantidade * Ingredientes.Quantidade))
	FROM Produto
	INNER JOIN Cardapio_Produto AS Ingredientes ON Produto.Cd_Produto = Ingredientes.Cd_Produto
	INNER JOIN Pedido_Cardapio AS ItemPedido ON ItemPedido.Nr_Cardapio = Ingredientes.Nr_Cardapio
	INNER JOIN Pedido ON Pedido.Nr_Pedido = ItemPedido.Nr_Pedido
	WHERE ItemPedido.Nr_Pedido = Pedido.Nr_Pedido
END

------------------------------------------------------------------------------------------------
Desenvolva um stored procedure capaz de listar a descrição e a quantidade para compra dos produtos que necessitam de reabastecimento, 
ou seja, Estoque_Atual <= Estoque_Minimo.

CREATE PROCEDURE Estoque_em_Falta 
AS 
SELECT Produto.Descricao AS 'Ingrediente', (Produto.Estoque_Minimo - Produto.Estoque_Atual) AS 'Faltando'
FROM Produto
WHERE Produto.Estoque_Minimo - Produto.Estoque_Atual > 0

Estoque_em_Falta
------------------------------------------------------------------------------------------------
Desenvolva um stored procedure capaz de apresentar a conta com os respectivos pedidos e valor total.--CREATE PROCEDURE MostrarContas--AS	    
	SELECT Conta_Mesa.Nr_Conta AS 'Número da Conta', Pedido_Cardapio.Nr_Pedido AS 'Número do Pedido', Cardapio.Descricao AS 'Cardápio', Pagamento.Valor AS 'Valor Total (R$)'
	FROM Pedido_Cardapio
	INNER JOIN Cardapio   ON Cardapio.Nr_Cardapio = Pedido_Cardapio.Nr_Cardapio	
	INNER JOIN Pedido     ON Pedido.Nr_Pedido     = Pedido_Cardapio.Nr_Pedido
	INNER JOIN Mesa       ON Pedido.Nr_Mesa       = Mesa.Nr_Mesa	
	INNER JOIN Conta_Mesa ON Mesa.Nr_Mesa         = Conta_Mesa.Nr_Mesa	
	INNER JOIN Conta      ON Conta.Nr_Conta       = Conta_Mesa.Nr_Conta
	INNER JOIN Pagamento  ON Pagamento.Nr_Conta   = Conta.Nr_Conta
	GROUP BY Pedido_Cardapio.Nr_Pedido, Cardapio.Descricao, Conta_Mesa.Nr_Conta, Pagamento.Valor
	ORDER BY Pedido_Cardapio.Nr_Pedido ASC

MostrarContas
------------------------------------------------------------------------------------------------
--Desenvolva um stored procedure que reajuste o preço do item do cardápio a partir da passagem dos parâmetros Nr_Cardapio e percentual de reajuste

CREATE PROCEDURE Alterar_ValorCardapio
    @Nr_Cardapio INT, @Reajuste DECIMAL(4,2),@Op CHAR(1)
 AS
 DECLARE @PrecoA DECIMAL(4,2)
 IF EXISTS (SELECT Nr_Cardapio from Cardapio WHERE Nr_Cardapio = @Nr_Cardapio)
BEGIN 
    SELECT @PrecoA = Preco from Cardapio WHERE Nr_Cardapio = @Nr_Cardapio 
    IF @Op = '-'
		BEGIN
			UPDATE Cardapio SET Preco = @PrecoA - (@PrecoA * @Reajuste) WHERE Nr_Cardapio = @Nr_Cardapio;
			SELECT * FROM CARDAPIO;
		END
    IF @Op = '+' 
		BEGIN
			UPDATE Cardapio SET Preco = @PrecoA + (@PrecoA * @Reajuste) WHERE Nr_Cardapio = @Nr_Cardapio;
			SELECT * FROM CARDAPIO;
		END
    ELSE
		PRINT 'A opção digitada não corresponde a nenhuma opção de Reajuste !'
END
ELSE
    PRINT 'Número de cardápio não encontrado !!'

Alterar_ValorCardapio 1, 0.5, '-'

------------------------------------------------------------------------------------------------
--Desenvolva uma função que, ao informar o Nr_Cardapio, apresente sua descrição e preço de custo

CREATE FUNCTION ConsultarCardapio(@Nr_Cardapio INT)	
	RETURNS TABLE	
AS	
	RETURN SELECT Cardapio.Nr_Cardapio, Cardapio.Descricao, SUM(Cardapio_Produto.Preco) AS 'Preço de Custo' FROM Cardapio				   				   
		   INNER JOIN Cardapio_Produto ON Cardapio.Nr_Cardapio = Cardapio_Produto.Nr_Cardapio				   				   
		   INNER JOIN Produto ON Produto.Cd_Produto = Cardapio_Produto.Cd_Produto
		   GROUP BY Cardapio.Descricao, Cardapio.Nr_Cardapio
	       HAVING Cardapio.Nr_Cardapio = @Nr_Cardapio				   

SELECT * FROM ConsultarCardapio(10) 
--------------------------------------------------------------------------------------------------------------
---------------------------------------CONSULTAS-------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--Consulta capaz de listar cada item do cardápio com os respectivos ingredientes ( produtos ) e quantidades.

SELECT Cardapio.Descricao AS 'Cardápio', Produto.Descricao AS 'Ingrediente', Cardapio_Produto.Quantidade
FROM Cardapio
INNER JOIN Cardapio_Produto ON Cardapio_Produto.Nr_Cardapio = Cardapio.Nr_Cardapio
INNER JOIN Produto ON Produto.Cd_Produto = Cardapio_Produto.Cd_Produto

--------------------------------------------------------------------------------------------------------------
--Consulta capaz de listar todos os funcionários (em ordem alfabética) com suas matrículas e seus respectivos cargos 

SELECT Funcionario.Matricula AS 'Matrícula', Funcionario.Nome, Cargo.Descricao AS 'Cargo' FROM Funcionario
INNER JOIN Cargo ON Funcionario.Cd_Cargo = Cargo.Cd_Cargo
ORDER BY Funcionario.Nome ASC

--------------------------------------------------------------------------------------------------------------
--Consulta capaz de listar os garçons com seu respectivo cargo, código do cargo, matrícula, nome e o total de contas abertas

SELECT Funcionario.Cd_Cargo AS 'Código do Cargo', Cargo.Descricao AS 'Cargo', Funcionario.Matricula AS 'Matrícula',
       Funcionario.Nome AS 'Funcionário', COUNT(Conta.Nr_Conta) AS 'Total de Contas Abertas'
FROM Cargo
INNER JOIN Funcionario ON Cargo.Cd_Cargo = Funcionario.Cd_Cargo
INNER JOIN Conta ON Funcionario.Matricula = Conta.Matricula
GROUP BY Cargo.Descricao, Funcionario.Nome, Funcionario.Cd_Cargo, Funcionario.Matricula
HAVING Funcionario.Cd_Cargo = 2
ORDER BY COUNT(Conta.Nr_Conta) DESC

-------------------------------------------------------------------------------------------------------------
Consulta capaz de listar as mesas que abriram conta com seus respectivos número da mesa, localização, número da conta, hora de abertura,
hora de fechamento, data de abertura e data de fechamento (mesmo as que não foram fechadas ainda)

SELECT Mesa.Nr_Mesa AS 'Número da Mesa', Mesa.Localizacao AS 'Localização (Interna ou Externa)', Conta.Nr_Conta AS 'Número da Conta' ,Conta.Hora_Abertura AS 'Hora de Abertura', 
	   Conta.Hora_Fechamento AS 'Hora de Fechamento', Conta.Data_Abertura AS 'Data de Abertura', Conta.Data_Fechamento AS 'Data de Fechamento'
FROM Mesa
INNER JOIN Conta_Mesa ON Mesa.Nr_Mesa = Conta_Mesa.Nr_Mesa
INNER JOIN Conta ON Conta.Nr_Conta = Conta_Mesa.Nr_Conta

--------------------------------------------------------------------------------------------------------------
Consulta capaz de listar as contas que foram pagas pelo cartão com seus respectivos número da conta, data de fechamento, hora de fechamento, 
o número do pagamento e o titular do cartão 

SELECT Conta.Nr_Conta AS 'Número da Conta', Conta.Data_Fechamento AS 'Data de Fechamento', Conta.Hora_Fechamento AS 'Hora de Fechamento', Pagamento.Nr_Pagamento AS 'Número do Pagamento', 
Cartao.Nome AS 'Titular do Cartão'
FROM Conta
INNER JOIN Pagamento ON Conta.Nr_Conta = Pagamento.Nr_Conta
INNER JOIN Cartao ON Cartao.Nr_Pagamento = Pagamento.Nr_Pagamento

--------------------------------------------------------------------------------------------------------------
--Consulta capaz de listar as contas que foram pagas pelo cheque com seus respectivos número da conta, data de fechamento, hora de fechamento,
--o número do pagamento, banco, agência e o número de cheque

SELECT Conta.Nr_Conta AS 'Número da Conta', Conta.Data_Fechamento AS 'Data de Fechamento', Conta.Hora_Fechamento AS 'Hora de Fechamento', Pagamento.Nr_Pagamento AS 'Número do Pagamento', 
       Cheque.Banco, Cheque.Agencia AS 'Agência', Cheque.Nr_Cheque AS 'Número do Cheque'
FROM Conta
INNER JOIN Pagamento ON Conta.Nr_Conta = Pagamento.Nr_Conta
INNER JOIN Cheque ON Cheque.Nr_Pagamento = Pagamento.Nr_Pagamento
--------------------------------------------------------------------------------------------------------------
Consulta capaz de listar quais contas estão fechadas e quais funcionários que a abriram

SELECT Funcionario.Matricula, Conta.Nr_Conta, Funcionario.Nome FROM Funcionario
INNER JOIN Conta ON Conta.Matricula = Funcionario.Matricula
WHERE Conta.Data_Fechamento IS NOT NULL AND Conta.Hora_Fechamento IS NOT NULL









