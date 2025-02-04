defmodule Tabuleiro do
  def criar(linhas, colunas) do
    List.duplicate(List.duplicate(".", colunas), linhas)
  end

  def exibir(tabuleiro) do
    Enum.each(tabuleiro, fn linha ->
      IO.puts(Enum.join(linha, " "))
    end)
    IO.puts("")
  end

  def atualizar(tabuleiro, linha, coluna, jogador) do
    simbolo = Jogador.simbolo(jogador)

    List.update_at(tabuleiro, linha, fn linha_atual ->
      List.update_at(linha_atual, coluna, fn _ -> simbolo end)
    end)
  end
end
