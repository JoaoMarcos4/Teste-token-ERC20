# FishCat ERC-20 Token

## Descrição do Projeto

Este projeto implementa um token compatível com o padrão **ERC-20** usando a linguagem **Solidity**.  
Ele foi desenvolvido como parte de um estudo sobre blockchain e contratos inteligentes na DIO, com uma personalização: o token aplica uma **taxa de queima (burn)** em cada transferência, reduzindo progressivamente o supply total.

---

## Funcionalidades Principais

- Implementação completa do padrão **ERC-20**
- Taxa de queima aplicada automaticamente em cada transferência
- Suporte a `approve` / `allowance` / `transferFrom`
- Estrutura de código clara e bem documentada
- Simulado em ambiente local (Ganache + MetaMask)

---

## Tecnologias Utilizadas

- **Solidity ^0.8.0** – linguagem de programação do contrato
- **Remix IDE** – ambiente de desenvolvimento e deploy
- **Ganache** – blockchain local para testes
- **MetaMask** – carteira de teste
- **GitHub** – versionamento do projeto

---

## Descrição do Contrato

O contrato `FishCat.sol` define um token ERC-20 com:

- **Nome:** FishCat
- **Símbolo:** FCAT
- **Decimais:** 18
- **Total Supply Inicial:** 10 FCAT

O contrato aplica uma **taxa de 0,1%** em cada transferência, que é **queimada**, reduzindo o `totalSupply`. Isso gera um efeito deflacionário.

---

## Como Testar

### Deploy Local

1. Inicie o **Ganache**
2. Importe uma conta no **MetaMask**
3. Abra o projeto no **Remix**
4. Compile usando Solidity ^0.8.0
5. Faça deploy em “Injected Provider (MetaMask)”

### Testes Realizados

- `transfer` → debita taxa e queima
- `approve` → autoriza spender
- `allowance` → consulta autorização
- `transferFrom` → transfere com taxa usando autorização

Consulte o arquivo `docs/simulation.md` para detalhes completos.

---

## Resultados Observados

- Todas as funções básicas do ERC-20 funcionam
- A taxa de queima é aplicada corretamente
- O totalSupply diminui conforme esperado
- Testado com MetaMask e Ganache

---

## Observações Finais

Este projeto é **educacional**, não foi auditado e não deve ser usado em produção.  
As simulações foram feitas em ambiente local para fins de aprendizado.

---

## Próximos Passos

Algumas melhorias possíveis:

- Adicionar testes automatizados (Hardhat / Foundry)
- Permitir configuração dinâmica da taxa
- Implementar mecanismos de governança
- Deploy em testnet pública


