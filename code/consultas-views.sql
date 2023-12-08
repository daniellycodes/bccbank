CREATE VIEW consulta1 AS
	SELECT cl.nomecompleto, cc.numero_conta, c.numero_cartao
	FROM Cliente AS cl
	JOIN ContaCorrente AS cc
	USING (cpf)
	JOIN CartaoCredito AS c
	USING (numero_conta)
	WHERE cl.email LIKE '%@aluno.ifce.edu.br%'
	ORDER BY nomecompleto;

CREATE VIEW consulta2 AS
	SELECT tipo_investimento, SUM(valor_investido) AS total_investido
	FROM Investimento
	GROUP BY tipo_investimento;

CREATE VIEW consulta3 AS
	SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, datanascimento, CURDATE()))) AS media_idade
	FROM Cliente
	WHERE cidade_endereco = 'Aracati';

CREATE VIEW consulta4 AS
	SELECT cc.numero_conta, e.id_emprestimo, e.valor_emprestimo, e.data_vencimento
	FROM Emprestimo AS e
	JOIN ContaCorrente AS cc
	USING (numero_conta)
	JOIN Cliente AS c
	USING (cpf)
	WHERE e.data_vencimento < CURDATE()
	AND c.cidade_endereco = 'Aracati'
	ORDER BY e.id_emprestimo;

CREATE VIEW consulta5 AS
	SELECT c.nomecompleto, t.data_transacao, t.valor_transacao
	FROM Cliente AS c
	JOIN ContaCorrente AS cc
	USING (cpf)
	JOIN TransacaoFinanceira AS t
	USING (numero_conta)
	WHERE c.estado_endereco = 'SP'
	ORDER BY nomecompleto;

CREATE VIEW consulta6 AS
	SELECT c.nomecompleto, cdc.numero_cartao, cdc.limite_credito
	FROM Cliente AS c
	JOIN ContaCorrente AS cc 
	USING (cpf)
	LEFT JOIN CartaoCredito AS cdc
	USING (numero_conta)
	WHERE cdc.limite_credito > 3000.00 
	AND cdc.limite_credito < 15000.00
	ORDER BY cdc.limite_credito;

CREATE VIEW consulta7 AS
	SELECT cidade_endereco AS cidade, COUNT(cidade_endereco) AS quantidade_clientes
	FROM Cliente
	GROUP BY cidade_endereco;

CREATE VIEW consulta8 AS
	SELECT c.nomecompleto, COUNT(t.id_transacao) AS total_transacoes
	FROM Cliente AS c
	JOIN ContaCorrente AS cc
	USING (cpf)
	LEFT JOIN TransacaoFinanceira AS t
	USING (numero_conta)
	GROUP BY c.cpf
	HAVING total_transacoes > 1;

CREATE VIEW consulta9 AS
	SELECT c.nomecompleto, COUNT(e.id_emprestimo) AS total_emprestimos
	FROM Cliente AS c
	JOIN ContaCorrente AS cc
	USING (cpf)
	LEFT JOIN Emprestimo AS e
	USING (numero_conta)
	GROUP BY c.cpf
	HAVING total_emprestimos = 0
	ORDER BY nomecompleto DESC;

CREATE VIEW consulta10 AS
	SELECT tipo_transacao, COUNT(*) AS quantidade_transacoes
	FROM TransacaoFinanceira
	WHERE data_transacao BETWEEN '2022-01-01' AND '2023-12-31'
	GROUP BY tipo_transacao
	ORDER BY quantidade_transacoes;
