-- View V_Emprestimos (OK)
-- View V_CLIENTE_CONTAS (OK)
-- View Lista Agencias (OK) Aline

-- Função: Saldo_conta (OK) Aline
-- Função: Atualiza_Saldo_Conta (OK)
-- Função: Saque
-- Função: Depósito (OK)
-- Função: Transferencia
-- Função: PagarEmprestimo 
-- Função: AtualizaSaldoConta
-- Função: Emprestimo_Saldo (OK)
-- Funcão: Emprestimo_VlPago (OK)

/**************************************/
/*         VIEW LISTA AGENCIAS        */
/**************************************/
create or replace view V_lista_agencias as
select 
	a.cidade || ' - ' || a.estado as cidade_estado,
	a.bairro, 
	b.nome as banco,
	a.numero as agencia,
	f.nome as gerente,
	ta.telefone
from
	banco b
	inner join agencia a on b.nire = a.nire
	inner join telefoneagencia ta on a.nire = ta.nire and a.numero = ta.numeroagencia
	inner join funcionario f on a.cpfgerente = f.cpf
order by
	cidade_estado,
	bairro,
	banco,
	agencia

select * from v_lista_agencias

/**************************************/
/*        FUNCTION CONTA_SALDO        */
/**************************************/
create or replace function Conta_saldo(p_banco NUMERIC(11), 
									   p_agencia NUMERIC(6), p_conta NUMERIC(6)) returns float 
as $$
declare
	resultado float := 0.0;
begin
	select 
		sum(se.valor) into resultado
	from 
		servico se
	where
			se.nire = p_banco
		and se.numeroagencia = p_agencia
		and se.numeroconta = p_conta;
	
	if (resultado is null) then
		resultado = 0.0;
	end if;
	
	return resultado;
end;

$$ language plpgsql;

select conta_saldo (7,7,7);

/**************************************/
/*         VIEW CLIENTE CONTAS        */
/**************************************/
create or replace view V_CLIENTE_CONTAS as
select 
	cl.nome as cliente,
	bc.nome as banco,
	co.numeroagencia as agencia,
	co.numero as conta,
	conta_saldo(co.nire, co.numeroagencia, co.numero) as saldo
from  
	conta as co
	inner join clienteconta as clco on co.nire = clco.nire and co.numeroagencia = clco.numeroagencia and co.numero = clco.numeroconta
	inner join cliente cl on cl.id = clco.idcliente
	inner join banco bc on co.nire = bc.nire

SELECT * FROM V_CLIENTE_CONTAS


/**************************************/
/*         FUNCTION DEPOSITO          */
/**************************************/
create or replace function conta_deposito (p_banco NUMERIC(11), p_agencia NUMERIC(6), p_conta NUMERIC(6), p_valor float) returns text 
as $$
declare
	resultado text := '';
	cliente int;
begin
	-- Descobrir o Cliente que pertence a essa conta
	select idcliente into cliente from servico where nire = p_banco and numeroagencia = p_agencia and numeroconta = p_conta;
	
	-- Inserir o deposito na tabela servico
	insert into servico(idcliente, numeroconta, numeroagencia, nire, valor, tipo, dataservico) 
				values( cliente, p_conta, p_agencia, p_banco, p_valor, 'Depósito', current_timestamp);
	
	-- Atualizar saldo da tabela conta
	update conta set saldo = conta_saldo(p_banco, p_agencia, p_conta) 
			where nire = p_banco and numeroagencia = p_agencia and numero = p_conta;
	
	resultado='Depósito efetuado com sucesso!!!';		
	
	return resultado;
end;
$$ language plpgsql;

select * from conta where nire = 1 and numeroagencia = 1 and numero = 1
select * from servico where nire = 1 and numeroagencia = 1 and numeroconta = 1
select * from servico

-- Mostrar estrutura da tabela
--SELECT * FROM information_schema.columns WHERE table_name ='servico';

-- descobrir ultima sequencia
select currval(pg_get_serial_sequence('servico', 'id'));
-- alterar a sequencia do id da tabela
ALTER SEQUENCE servico_id_seq RESTART WITH 89

select conta_deposito(1,1,1,320.75)

/**************************************/
/*  FUNCTION ATUALIZA_SALDO_CONTAS    */
/**************************************/
create or replace function Atualiza_Saldo_Conta() returns setof conta 
as $$
declare
	linha conta%ROWTYPE;
begin
	for linha in select * from conta loop
		if (linha.saldo != conta_saldo(linha.nire, linha.numeroagencia, linha.numero)) then
			update conta set saldo = conta_saldo(linha.nire, linha.numeroagencia, linha.numero) 
			where nire = linha.nire and numeroagencia = linha.numeroagencia and numero = linha.numero;
		end if;	
	end loop;	
end;
$$ language plpgsql;

select Atualiza_Saldo_Conta()
select * from conta


/**************************************/
/*   FUNCTION EMPRESTIMO VALOR PAGO   */
/**************************************/
create or replace function Emprestimo_VlPago (p_idemprestimo int) returns float 
as $$
declare
	resultado float := 0.0;
begin
	select 
		sum(pg.valor) into resultado 
	from 
		pagamento as pg 
	where 
		pg.idemprestimo = p_idemprestimo;
		
	if (resultado is null) then
		resultado = 0.0;
	end if;
	
	return resultado;
end;

$$ language plpgsql;

select * from emprestimo em where em.id = 20110001;
select Emprestimo_VlPago(20110007);
select * from pagamento pg where pg.idemprestimo = 20110001

/**************************************/
/*     FUNCTION EMPRESTIMO SALDO      */
/**************************************/
create or replace function Emprestimo_Saldo (in p_id int) returns float 
as $$
declare
	resultado float := 0.0;
begin
	select 
		(em.valor - Emprestimo_VlPago(em.id)) into resultado
	from 
		emprestimo as em 
	where 
		em.id = p_id;	
		--em.id = 20110001
	
	if (resultado is null) then
		resultado = 0.0;
	end if;
	
	return resultado;
end;
$$ language plpgsql;


select Emprestimo_Saldo(20110001);

/**************************************/
/*         VIEW EMPRESTIMOS           */
/**************************************/
create or replace view V_Emprestimos as
select
	cl.nome as cliente,
	bc.nome as banco,
	ag.numero as agencia,
	em.id as contato,
	em.valor as valor_contratado,
	Emprestimo_VlPago(em.id) as valor_pago,
	Emprestimo_Saldo(em.id) as saldo
	
from 
	realiza as re
	inner join emprestimo as em on re.idemprestimo = em.id 
	inner join cliente as cl on re.idcliente = cl.id
	inner join funcionario as fu on re.cpffuncionario = fu.cpf
	inner join agencia as ag on fu.numeroagencia = ag.numero and fu.nire = ag.nire
	inner join banco as bc on ag.nire = bc.nire
order by
	cl.nome
	
select * from V_Emprestimos









