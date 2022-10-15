'2) Crie uma VIEW chamada ULTIMO_PEDIDO_VIEW para exibir qual o último pedido de cada cliente.'

CREATE VIEW bd_estrutura.ULTIMO_PEDIDO_VIEW AS
	Select bd_estrutura.CLIENTE.NOME,  from bd_estrutura.Cliente,
		   bd_estrutura.PEDIDO.DATAPEDIDO (ORDER BY -bd_estrutura.datapedido), from bd_estrutura.pedido,
		   WHERE 