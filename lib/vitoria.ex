defmodule Vitoria do
  def jogo_terminou?(tabuleiro) do
    verificar_vencedor(tabuleiro) or verificar_empate(tabuleiro)
  end

  def verificar_vencedor(tabuleiro) do
    verificar_linhas(tabuleiro) or
      verificar_colunas(tabuleiro) or
      verificar_diagonais(tabuleiro)
  end

  def verificar_linhas(tabuleiro) do
    Enum.any?(tabuleiro, &sequencia_vencedora?/1)
  end

  def verificar_colunas(tabuleiro) do
    tabuleiro
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.any?(&sequencia_vencedora?/1)
  end

  def verificar_diagonais(tabuleiro) do
    tabuleiro
    |> extrair_diagonais()
    |> Enum.any?(&sequencia_vencedora?/1)
  end

  def extrair_diagonais(tabuleiro) do
    tamanho = length(tabuleiro)

    # extrair diagonais principais e secundárias da parte superior
    diagonais_principais =
      for i <- 0..(tamanho - 4) do
        for j <- 0..(tamanho - 1 - i) do
          Enum.at(Enum.at(tabuleiro, j), i + j)
        end
      end

    diagonais_secundarias =
      for i <- 0..(tamanho - 4) do
        for j <- 0..(tamanho - 1 - i) do
          Enum.at(Enum.at(tabuleiro, i + j), j)
        end
      end

    # extrair diagonais principais e secundárias da parte inferior
    diagonais_principais_baixo =
      for i <- 1..(tamanho - 4) do
        for j <- 0..(tamanho - 1 - i) do
          Enum.at(Enum.at(tabuleiro, i + j), j)
        end
      end

    diagonais_secundarias_baixo =
      for i <- 1..(tamanho - 4) do
        for j <- 0..(tamanho - 1 - i) do
          Enum.at(Enum.at(tabuleiro, j), i + j)
        end
      end

    diagonais_principais ++ diagonais_secundarias ++ diagonais_principais_baixo ++ diagonais_secundarias_baixo
  end



  defp sequencia_vencedora?(linha) do
    linha
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.any?(fn [a, b, c, d] -> a != "." and a == b and b == c and c == d end)
  end

  def verificar_empate(tabuleiro) do
    not Enum.any?(tabuleiro, fn linha -> "." in linha end)
  end

  def encontrar_vencedor(tabuleiro) do
    vencedor =
      verificar_linhas_vencedoras(tabuleiro) ||
      verificar_colunas_vencedoras(tabuleiro) ||
      verificar_diagonais_vencedoras(tabuleiro)

    case vencedor do
      "X" -> 1
      "O" -> 2
      "#" -> 3
      _ -> "ninguém"
    end
  end

  defp verificar_linhas_vencedoras(tabuleiro) do
    Enum.find_value(tabuleiro, &sequencia_vencedora_linha/1)
  end

  defp verificar_colunas_vencedoras(tabuleiro) do
    tabuleiro
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.find_value(&sequencia_vencedora_linha/1)
  end

  defp verificar_diagonais_vencedoras(tabuleiro) do
    tabuleiro
    |> extrair_diagonais()
    |> Enum.find_value(&sequencia_vencedora_linha/1)
  end

  defp sequencia_vencedora_linha(linha) do
    linha
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.find_value(fn [a, b, c, d] ->
      if a != "." and a == b and b == c and c == d, do: a, else: nil
    end)
  end


end
