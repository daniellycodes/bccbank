# **BCC Bank**

## **Projeto de Banco de Dados I**

**Descrição:**
Neste repositório consta o projeto desenvolvido para a disciplina de Banco de Dados I no Instituto Federal de Educação, Ciência e Tecnologia do Ceará, campus Aracati. O trabalho foi dividido em duas fases distintas, refletindo o aprendizado teórico e prático adquirido ao longo do curso.

## Fase 1: Construção do Modelo Entidade-Relacionamento (MER) e Modelo Relacional (MR)
Na primeira etapa, o foco foi na concepção e elaboração do Modelo Entidade-Relacionamento (MER) e, posteriormente, sua tradução para o Modelo Relacional (MR). Utilizou-se uma abordagem cuidadosa para mapear as entidades, relacionamentos e atributos, garantindo uma representação precisa e coerente do domínio do problema.

### Modelo Entidade-Relacionamento:
<p align="center">
  <img src="https://github.com/daniellycodes/bccbank/blob/main/images/MER.jpg" alt="Modelo Relacional" width="80%">
</p>

### Modelo Relacional:
<p align="center">
  <img src="https://github.com/daniellycodes/bccbank/blob/main/images/MR.png" alt="Modelo Relacional" width="60%">
</p>

## [Fase 2: Transformação para o Modelo Físico utilizando MySQL](https://github.com/daniellycodes/bccbank/blob/main/code/bccbank-schema.sql)
Na segunda fase do projeto, concentramo-nos na transição do modelo conceitual e lógico para o modelo físico, empregando a ferramenta MySQL. Esta etapa envolveu a implementação efetiva do banco de dados, considerando as nuances específicas do MySQL. Foram aplicados os conceitos aprendidos em sala de aula para otimizar a estrutura do banco e garantir a integridade e eficiência.

* [BCC Bank - Schema](https://github.com/daniellycodes/bccbank/blob/main/code/bccbank-schema.sql)
* [BCC Bank - Data](https://github.com/daniellycodes/bccbank/blob/main/code/bccbank-data.sql)

## Consultas e Aplicação do Conteúdo Aprendido.
Após a modelagem do banco de dados, a etapa subsequente consiste na elaboração de consultas avançadas. Utilizando as funcionalidades oferecidas pelo MySQL, exploramos e aplicamos os conceitos aprendidos em aula para criar consultas sofisticadas e eficientes. Este processo não apenas consolidou o conhecimento teórico, mas também proporcionou uma compreensão prática da importância do design de banco de dados na otimização de consultas.

* [Lista completa das consultas](https://github.com/daniellycodes/bccbank/blob/main/code/consultas-views.sql)

#### Consulta 1:
Selecione o nome completo, número da conta e número do cartão dos Clientes cujo domínio do e-mail faça parte do Instituto Federal de Educação, Ciência e Tecnologia do Ceará. Ordene a saída pelo nome completo.

```
	SELECT cl.nomecompleto, cc.numero_conta, c.numero_cartao
	FROM Cliente AS cl
	JOIN ContaCorrente AS cc
	USING (cpf)
	JOIN CartaoCredito AS c
	USING (numero_conta)
	WHERE cl.email LIKE '%@aluno.ifce.edu.br%'
	ORDER BY nomecompleto;
```

#### Consulta 2:
Calcule o total investido por tipo de investimento.

```
	SELECT tipo_investimento, SUM(valor_investido) AS total_investido
	FROM Investimento
	GROUP BY tipo_investimento;
```

#### Consulta 3:
Selecione a média da idade dos Clientes que moram na cidade de Aracati;

```
	SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, datanascimento, CURDATE()))) AS media_idade
	FROM Cliente
	WHERE cidade_endereco = 'Aracati';
```

#### Consulta 4:
Selecione o número da conta, o ID do empréstimo, o valor do empréstimo e a data de vencimento dos empréstimos já vencidos dos moradores da cidade de Aracati. Ordene o resultado pelo ID do empréstimo;

```
	SELECT cc.numero_conta, e.id_emprestimo, e.valor_emprestimo, e.data_vencimento
	FROM Emprestimo AS e
	JOIN ContaCorrente AS cc
	USING (numero_conta)
	JOIN Cliente AS c
	USING (cpf)
	WHERE e.data_vencimento < CURDATE()
	AND c.cidade_endereco = 'Aracati'
	ORDER BY e.id_emprestimo;
```

#### Consulta 5:
Liste o nome completo, a data de transação e o valor de transação financeira dos moradores do estado de São Paulo. Ordene a saída pelo nome completo.

```
	SELECT c.nomecompleto, t.data_transacao, t.valor_transacao
	FROM Cliente AS c
	JOIN ContaCorrente AS cc
	USING (cpf)
	JOIN TransacaoFinanceira AS t
	USING (numero_conta)
	WHERE c.estado_endereco = 'SP'
	ORDER BY nomecompleto;
```

#### Consulta 6:
Selecione o nome completo, o número do cartão de crédito e o limite de crédito dos clientes cujo limite seja maior que R$3.000,00 e menor que R$15.000,00. Ordene a saída pelo limite.

```
	SELECT c.nomecompleto, cdc.numero_cartao, cdc.limite_credito
	FROM Cliente AS c
	JOIN ContaCorrente AS cc 
	USING (cpf)
	LEFT JOIN CartaoCredito AS cdc
	USING (numero_conta)
	WHERE cdc.limite_credito > 3000.00 
	AND cdc.limite_credito < 15000.00
	ORDER BY cdc.limite_credito;
```

#### Consulta 7:
Selecione o nome das cidades sem repetições e conte a quantidade de clientes que moram em cada uma delas. Em seguida, agrupe a quantidade por cidade.

```
	SELECT cidade_endereco AS cidade, COUNT(cidade_endereco) AS quantidade_clientes
	FROM Cliente
	GROUP BY cidade_endereco;
```

#### Consulta 8:
Selecione o nome do cliente e a quantidade de transações financeiras dos clientes cuja quantidade seja maior que 1.

```
	SELECT c.nomecompleto, COUNT(t.id_transacao) AS total_transacoes
	FROM Cliente AS c
	JOIN ContaCorrente AS cc
	USING (cpf)
	LEFT JOIN TransacaoFinanceira AS t
	USING (numero_conta)
	GROUP BY c.cpf
	HAVING total_transacoes > 1;
```

#### Consulta 9:
Selecione o nome do cliente e a quantidade de empréstimos dos clientes que não realizaram nenhum empréstimo. Coloque os nomes em ordem alfabética decrescente.

```
	SELECT c.nomecompleto, COUNT(e.id_emprestimo) AS total_emprestimos
	FROM Cliente AS c
	JOIN ContaCorrente AS cc
	USING (cpf)
	LEFT JOIN Emprestimo AS e
	USING (numero_conta)
	GROUP BY c.cpf
	HAVING total_emprestimos = 0
	ORDER BY nomecompleto DESC;
```

#### Consulta 10:
Selecione os tipos de transação bancária com as respectivas quantidades de cada uma que foram realizadas entre os anos de 2022 e 2023. Ordene pela quantidade.

```
  	SELECT tipo_transacao, COUNT(*) AS quantidade_transacoes
	FROM TransacaoFinanceira
	WHERE data_transacao BETWEEN '2022-01-01' AND '2023-12-31'
	GROUP BY tipo_transacao
	ORDER BY quantidade_transacoes;
```

Este repositório serve como registro do trabalho desenvolvido ao longo do semestre, proporcionando uma visão abrangente do processo de construção e otimização de um banco de dados, desde sua concepção até a aplicação prática de consultas.

### Equipe:
* [Danielly](https://github.com/daniellycodes)
* [João Pedro](https://github.com/IBliind)
* [Nicolle](https://github.com/nicollesouza01)
* [João Victor](https://github.com/VictorGuimaresL)
* [Alane]
