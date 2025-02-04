# Desafio dos Três

Esse projeto implementa o [desafio](https://github.com/adolfont/caes005-introduction-to-functional-programming/tree/main/offerings/2024/desafio_dos_tres) proposto na cadeira de Introduction to Functional Programming do PPGCA da UTFPR.

Um jogo de tabuleiro para 3 jogadores, onde o objetivo é alinhar 4 símbolos consecutivos em uma linha, coluna ou diagonal. Os jogadores podem substituir símbolos de outros jogadores, mas seguindo regras específicas para evitar apagamentos consecutivos e retaliações diretas.

## Requisitos para rodar o jogo

para rodar este jogo, você precisa ter o **erlang** e o **elixir** instalados.

### Instalando erlang e elixir

1. baixe e instale **erlang/otp** e **elixir**:
   - [instalador oficial do elixir](https://elixir-lang.org/install.html)
   - [instalador oficial do erlang](https://www.erlang.org/downloads)

2. verifique a instalação rodando no terminal:

   ```sh
   elixir -v
   ```

   isso deve exibir a versão do elixir instalada, algo como:

   ```
   erlang/otp 27 [erts-15.1.2]
   elixir 1.15.2 (compiled with erlang/otp 27)
   ```

## Como rodar o jogo?

1. clone este repositório ou baixe os arquivos:

   ```sh
   git clone https://github.com/seu-usuario/jogo.git
   cd jogo
   ```

2. instale as dependências:

   ```sh
   mix deps.get
   ```

3. rode o jogo:

   ```sh
   mix run -e "Jogo.start