defmodule Jogador do
  def realizar_jogada(tabuleiro, jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral) do
    IO.puts("Jogador #{jogador_atual}, é sua vez!")
    Tabuleiro.exibir(tabuleiro)

    {linha, coluna} = obter_posicao()

    simbolo_atual = Enum.at(Enum.at(tabuleiro, linha), coluna)

    if simbolo_atual != "." and simbolo_atual != simbolo(jogador_atual) do
      IO.puts("A posição já tem um símbolo. Deseja sobrescrevê-lo? (s/n)")
      resposta = IO.gets("> ") |> String.trim() |> String.downcase()

      if resposta != "s" do
        IO.puts("Escolha outra posição.")
        realizar_jogada(tabuleiro, jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral)
      end
    end

    if jogada_valida?(tabuleiro, linha, coluna, jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral) do
      novo_tabuleiro = Tabuleiro.atualizar(tabuleiro, linha, coluna, jogador_atual)
      nova_jogada = %{
        linha: linha,
        coluna: coluna,
        jogador: jogador_atual,
        apagou_simbolo: simbolo_atual != "." and simbolo_atual != simbolo(jogador_atual),
        jogador_que_foi_apagado:
          if simbolo_atual != "." and simbolo_atual != simbolo(jogador_atual) do
            # converte o símbolo apagado para o número do jogador que jogou
            case simbolo_atual do
              "X" -> 1
              "O" -> 2
              "#" -> 3
              _ -> nil
            end
          else
            nil
          end
      }

      {novo_tabuleiro, nova_jogada}
    else
      IO.puts("Jogada inválida! Escolha outra posição.")
      realizar_jogada(tabuleiro, jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral)
    end
  end

  def jogada_valida?(tabuleiro, linha, coluna, jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral) do
    if not posicao_valida?(tabuleiro, linha, coluna) do
      false  # se a posição escolhida não estiver dentro dos limites do tabuleiro
    else
      simbolo_atual = Enum.at(Enum.at(tabuleiro, linha), coluna)

      cond do
        simbolo_atual == "." -> true  # se a célula é vazia, a jogada é válida

        simbolo_atual != simbolo(jogador_atual) ->

          pode_apagar?(jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral, simbolo_atual)

        true -> false  # se for o próprio símbolo do jogador, não pode sobrescrever
      end
    end
  end

  defp pode_apagar?(jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral, simbolo_atual) do
    if ultima_jogada_do_jogador == nil do
      true
    else
      cond do
        ultima_jogada_do_jogador.apagou_simbolo ->
          IO.puts("Você não pode apagar símbolos em rodadas consecutivas! Jogue em uma célula vazia.")
          false

        ultima_jogada_geral != nil and
          ultima_jogada_geral.apagou_simbolo and
          ultima_jogada_geral.jogador != jogador_atual and
          ultima_jogada_geral.jogador_que_foi_apagado == jogador_atual and
          simbolo_atual == Jogador.simbolo(ultima_jogada_geral.jogador) ->
          IO.puts("Você não pode apagar este símbolo porque ele apagou o seu na jogada anterior!")
          false

        true -> true
      end
    end
  end

  defp posicao_valida?(tabuleiro, linha, coluna) do
    linhas = length(tabuleiro)
    colunas = length(List.first(tabuleiro))

    linha in 0..(linhas - 1) and coluna in 0..(colunas - 1)
  end

  defp obter_posicao do
    linha = obter_numero("Escolha a linha (0 a 3):")
    coluna = obter_numero("Escolha a coluna (0 a 3):")
    {linha, coluna}
  end

  defp obter_numero(mensagem) do
    IO.puts(mensagem)
    entrada = IO.gets("> ") |> String.trim()

    case Integer.parse(entrada) do
      {numero, ""} -> numero
      _ ->
        IO.puts("Entrada inválida! Digite um número válido.")
        obter_numero(mensagem)
    end
  end

  def simbolo(jogador) do
    case jogador do
      1 -> "X"
      2 -> "O"
      3 -> "#"
    end
  end

  def proximo(jogador_atual) do
    rem(jogador_atual, 3) + 1
  end
end
