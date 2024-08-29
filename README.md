# Digital Wallet API

## Descrição

Uma simples API para gerenciamento de carteira.

## Tecnologias

- **Ruby**: 3.2.2
- **Rails**: 7.1.4
- **PostgreSQL**: 16.3
- **Bibliotecas**: Ransack, Kaminari, jsonapi-rails, jwt, rspec-rails

## Instalação

1. Clone o repositório:

```bash
git clone git@github.com:gabrieldrgl/digital-wallet-api.git
cd digital-wallet-api
```

2. Instale as dependências:

```bash
bundle install
```

3. Crie o banco de dados e execute as migrações:
```bash
rails db:create
rails db:migrate
```

## Uso

- Inicie o servidor Rails:

```bash
rails s
```

- Acesse a API em http://localhost:3000.

- Aqui estão alguns exemplos de requisições para interagir com a API:

### Registrar um Novo Usuário

**POST** `http://localhost:3000/signup`

**Body:**

```json
{
    "name": "John Doe",
    "email": "johndoe@example.com",
    "password": "password123"
}
```

### Fazer Login

**POST** `http://localhost:3000/signin`

**Body:**

```json
{
    "email": "johndoe@example.com",
    "password": "password123"
}
```

### Consultar Saldo

**GET** `http://localhost:3000/balance`

**Headers:**

```sql
Authorization: Bearer 'seu token jwt'
```

### Criar uma Transação

**POST** `http://localhost:3000/transactions`

**Body:**

```json
{
  "transaction": {
    "amount": 10,
    "transaction_type": "deposit",
    "description": "Initial deposit"
  }
}
```

**Headers:**

```sql
Authorization: Bearer 'seu token jwt'
```

### Listar Transações

**GET** `http://localhost:3000/transactions`

```sql
Authorization: Bearer 'seu token jwt'
```

Parâmetros de Consulta:

- q[transaction_type_eq]: Filtra transações pelo tipo de transação (ex: deposit, withdrawal).
- q[created_at_gteq]: Filtra transações com data de criação maior ou igual à data fornecida (formato: YYYY-MM-DD).
- q[created_at_lteq]: Filtra transações com data de criação até data fornecida (formato: YYYY-MM-DD).
- page: Número da página para paginação.
- per_page: Número de itens por página.

Exemplo de Requisição com Filtragem e Paginação:

**GET** `http://localhost:3000/transactions?q[transaction_type_eq]=deposit&q[created_at_gteq]=2024-08-01&page=1&per_page=10`

Neste exemplo, a requisição busca transações do tipo deposit que foram criadas a partir de 1º de agosto de 2024, e retorna a primeira página com até 10 transações por página.
