# Loyalty Marketplace

Loyalty Marketplace é um projeto de marketplace para compra e venda de produtos usando tokens de fidelidade. A aplicação utiliza Next.js, ethers.js para integração com MetaMask e react-toastify para notificações de transações.

## Funcionalidades

- Conexão com MetaMask.
- Exibição de saldo de tokens ERC-20.
- Compra de produtos utilizando tokens.

## Tecnologias Utilizadas

- Next.js
- TypeScript
- TailwindCSS
- ethers.js
- react-toastify

## Instalação

1. Clone o repositório:
   ```bash
   git clone <url-alura>
   cd loyalty-marketplace
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

3. Inicie o servidor de desenvolvimento:
   ```bash
   npm run dev
   ```

## Configuração

### Dependências

Verifique o `package.json` para todas as dependências.

### Estrutura do Projeto

- `components/MetaMaskConnect.tsx`: Componente para conectar à MetaMask e exibir saldo.
- `components/ProductList.tsx`: Componente para listar produtos e comprar com tokens.
- `lib/token.ts`: Funções para interagir com o contrato ERC-20.
- `lib/wallet.ts`: Função para conectar à MetaMask e obter saldo de tokens.

## Uso

1. Conecte sua carteira MetaMask clicando no botão "Conecte sua carteira".
2. Visualize seu saldo de tokens no cabeçalho.
3. Compre produtos clicando no botão "Comprar" ao lado do produto desejado.
