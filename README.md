# Teste token ERC-20

Projeto simples baseado em um curso da DIO sobre Blockchain, para fins educacionais.

Se trata de um token na linguagem solidity no padrão ERC-20, que implementa uma taxa de queima por transação.

---

## Objetivo do projeto:

 - Aprender a estrutura do token ERC-20
 - Desenvolver habilidades com a linguagem solidity
 - Integrar Remix + Ganache + MetaMask
 - Simular um contrato dentro de uma blockchain

---

## Tecnologias utilizadas:

 - Solidity ^0.8.0
 - Remix IDE
 - Ganache
 - MetaMask
 - Git e GitHub

---

## Descrição do token:

 - Interface ERC-20 ( Contêm as assinaturas que definem o contrato ERC-20 )
 - Contrato FishCat ( Contêm as implementações do contrato )
 - Variáveis principais:

   - Balances ( Controla o saldo de cada endereço )
   - Allowed ( Controla as autorizações de um endereço, para que outro endereço possa enviar uma quantia estimada )
   - TotalSupply_ ( total de tokens )
   - BURN_FEE e FEE_DENOMINATOR ( calculam a taxa da queima )

 - Funções no contrutor:

   - Implemetações dos GETTERS da interface ERC-20
   - Transfer
   - Approve
   - TranferFrom

---

## Lógica da taxa:

No projeto foi implementada uma taxa por transferência, seu objetivo é diminuir a inflação do token e manter seu valor.

A taxa consiste em 1% do valor transferido, que é descontado automaticamente no valor da tranferência, fazendo auteração somente no valor recebido.

Esse valor é "queimado" e o totalSupply diminui, garantindo a valorzação do token.

---

## Deploy e simulação:

O deploy do projeto foi feito atavés do ganache via remix, para ambiente eu selecionei o MetaMask. Dessa forma eu simulei as transações como se acontecessem em uma aplicação real. Durante a simulação foi testado as seguintes funções do contrato:

 - Transfer
 - Approve
 - TransferFrom
 - Allowance

---

## Observações:

 - Esse é um projeto da DIO e foi feita apenas algumas modificações
 - É um projeto educacional e apresenta nivel baixo de conhecimento

---























