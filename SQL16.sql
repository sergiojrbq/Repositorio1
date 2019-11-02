#Consultas Condicionais
USE sucos_vendas;

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga'
OR TAMANHO = '470 mL';

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga'
AND TAMANHO = '470 mL';
SELECT * FROM tabela_de_produtos WHERE NOT (SABOR = 'Manga'
AND TAMANHO = '470 mL');

SELECT * FROM tabela_de_produtos WHERE NOT (SABOR = 'Manga'
OR TAMANHO = '470 mL');

SELECT * FROM tabela_de_produtos WHERE SABOR = 'Manga'
AND NOT (TAMANHO = '470 mL');

SELECT * FROM tabela_de_produtos WHERE SABOR IN ('Manga','Laranja');

SELECT * FROM tabela_de_clientes WHERE CIDADE IN ('Rio de Janeiro', 'São Paulo')
AND IDADE >= 20;

SELECT * FROM tabela_de_clientes WHERE CIDADE IN ('Rio de Janeiro', 'São Paulo')
AND IDADE >= 20 AND IDADE <=22;

# Consultas Like

USE sucos_vendas;
SELECT * FROM tabela_de_produtos WHERE SABOR LIKE '%Maça%';

SELECT * FROM tabela_de_produtos WHERE SABOR LIKE '%Maça%'
AND EMBALAGEM = 'Pet';

SELECT * FROM tabela_de_clientes WHERE NOME LIKE '%Mattos%';

#Testando Distinct

SELECT EMBALAGEM, TAMANHO FROM tabela_de_produtos;
SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos;
SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos WHERE SABOR = 'Laranja';
SELECT DISTINCT BAIRRO FROM tabela_de_clientes where CIDADE = 'Rio de Janeiro';

#Testando Limit
SELECT * FROM tabela_de_produtos;
SELECT * FROM tabela_de_produtos LIMIT 5;
SELECT * FROM tabela_de_produtos LIMIT 2,3;
SELECT * FROM notas_fiscais WHERE DATA_VENDA = '2017-01-01' LIMIT 10;

#Testando ORDER BY
SELECT * FROM tabela_de_produtos;
SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA;
SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA DESC;
SELECT * FROM tabela_de_produtos ORDER BY EMBALAGEM ASC, PRECO_DE_LISTA DESC;
SELECT * FROM tabela_de_produtos where NOME_DO_PRODUTO = 'Linha Refrescante - 1 Litro - Morango/Limão';
SELECT * FROM itens_notas_fiscais where CODIGO_DO_PRODUTO = 1101035 order by QUANTIDADE DESC limit 1;

#Testando Agrupamento
SELECT ESTADO, LIMITE_DE_CREDITO FROM tabela_de_clientes;
SELECT EMBALAGEM, PRECO_DE_LISTA FROM tabela_de_produtos;
SELECT EMBALAGEM, max(PRECO_DE_LISTA) as 'Maior Preço'FROM tabela_de_produtos group by EMBALAGEM order by PRECO_DE_LISTA DESC;
SELECT EMBALAGEM, COUNT(*) as Contador FROM tabela_de_produtos group by EMBALAGEM;
SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) as 'Limite Total' FROM tabela_de_clientes group by BAIRRO order by BAIRRO;
SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) as 'Limite Total' FROM tabela_de_clientes 
where CIDADE = 'Rio de Janeiro' group by BAIRRO order by BAIRRO;
SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) as 'Limite Total' FROM tabela_de_clientes 
where CIDADE = 'Rio de Janeiro' group by ESTADO, BAIRRO order by BAIRRO;
SELECT MAX(QUANTIDADE) as 'Maior Quantidade' from itens_notas_fiscais where CODIGO_DO_PRODUTO = 1101035;
SELECT COUNT(*) as 'Contagem de vendas' from itens_notas_fiscais where CODIGO_DO_PRODUTO = 1101035 and QUANTIDADE = 99;

#Testando Having
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS 'Soma de Crédito' from tabela_de_clientes 
group by ESTADO;
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS 'Soma de Crédito' from tabela_de_clientes 
group by ESTADO HAVING SUM(LIMITE_DE_CREDITO) > 900000;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS 'Maior Preço', MIN(PRECO_DE_LISTA) AS 'Menor Preço' 
FROM tabela_de_produtos group by EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <=80;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS 'Maior Preço', MIN(PRECO_DE_LISTA) AS 'Menor Preço' 
FROM tabela_de_produtos group by EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <=80 AND MAX(PRECO_DE_LISTA) >=5;

SELECT CPF, COUNT(*) from notas_fiscais WHERE year(DATA_VENDA) = 2016
GROUP BY CPF HAVING COUNT(*) > 2000;


#Teste Case

SELECT * FROM tabela_de_produtos;

SELECT NOME_DO_PRODUTO AS 'Produto', PRECO_DE_LISTA,
CASE 
WHEN PRECO_DE_LISTA >= 12  THEN 'CARO'
WHEN PRECO_DE_LISTA >= 7 and PRECO_DE_LISTA <12  THEN 'EM CONTA'
ELSE 'Barato'
END AS 'Status Produto' FROM tabela_de_produtos;

SELECT EMBALAGEM,
CASE 
WHEN PRECO_DE_LISTA >= 12  THEN 'CARO'
WHEN PRECO_DE_LISTA >= 7 and PRECO_DE_LISTA <12  THEN 'EM CONTA'
ELSE 'Barato'
END AS 'Status Produto', AVG(PRECO_DE_LISTA) AS 'Preço Médio'
FROM tabela_de_produtos
GROUP BY EMBALAGEM, 
CASE 
WHEN PRECO_DE_LISTA >= 12  THEN 'CARO'
WHEN PRECO_DE_LISTA >= 7 and PRECO_DE_LISTA <12  THEN 'EM CONTA'
ELSE 'Barato'
END;

SELECT NOME,
CASE
	WHEN year(DATA_DE_NASCIMENTO) < 1990 THEN 'VELHOS'
    WHEN year(DATA_DE_NASCIMENTO) >= 1990 AND year(DATA_DE_NASCIMENTO) < 1995 THEN 'JOVENS'
    ELSE 'Criança'
END AS 'Faixa Etária'
FROM tabela_de_clientes;