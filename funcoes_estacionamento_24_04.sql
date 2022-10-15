select * from cliente ;
select * from estaciona ;
select * from modelo ;
select * from patio ;
select * from veiculo ;

/* 1- Criar uma função que receba por parâmetro a data do estacionamento e retorne 
(também por parâmetros o cpf e o nome do cliente mais velho que estacionou nesse dia.*/

create or replace function data_estacionamento (dia date) returns table (nome varchar(60), 
																		 data_nasc date, cpf varchar(14))
AS $$
begin
	return query
	select 
		cliente.nome, cliente.dtnasc as nascimento , cliente.cpf
	from 
		veiculo
	inner join 
		estaciona on estaciona.placa = veiculo.placa
	inner join 
		cliente on cliente.cpf = veiculo.cpf 
	where
		estaciona.dtentrada = dia
	order by 
		cliente.nome , cliente.dtnasc , cliente.cpf
	limit 1;
	return;
end;	
$$ language plpgsql;

select data_estacionamento('2021-03-21');


/* 2- Criar uma função que receba por parâmetro a data do estacionamento e retorne a placa,
cor e dono dos veículos estacionados nesse dia. O retorno deve ser do tipo TABLE. */

create or replace function data_veiculo(dia date) returns table (nome varchar(60), placa varchar(8), cor varchar(20))
AS $$
begin
	return query
	select 
		cliente.nome, veiculo.placa , veiculo.cor
	from 
		veiculo
	inner join 
		estaciona on estaciona.placa = veiculo.placa
	inner join 
		cliente on cliente.cpf = veiculo.cpf 
	where
		estaciona.dtentrada = dia;
	return;
end;	
$$ language plpgsql;

select data_veiculo('2021-03-15');


/* 3- Criar uma função que antes de atualizar os dados de saída do veículo no estacionamento,
verifique se a data é maior ou igual a data de entrada no estacionamento, caso seja igual 
verificar o horário de saída, que deve ser maior que o de entrada. Os dados estando corretos 
efetuar a atualização, caso contrário retornar uma mensagem de erro. */

create or replace function update_dados(nova_data date, nova_hora time, valor int ) returns text
AS $$
declare 
 mensagem text;
begin
	if (nova_data >= dtentrada) from estaciona where estaciona.cod = valor then
		if (nova_hora > hrentrada) from estaciona where estaciona.cod = valor then
			update estaciona set dtsaida = nova_data, hrsaida = nova_hora ; 
			select 'Os dados foram atualizados com sucesso!' into mensagem as Confirmacao;
		else
			select 'O horario é maior ou igual a hora de entrada, ERRO!' into mensagem  as ERRO;
		end if;	
	else
		select 'A data é menor que a data de entrada, ERRO!' into mensagem as ERRO;
	end if;
	return mensagem; 
end;	
$$ language plpgsql;

select update_dados('2021-03-15','09:00:00',1);






















