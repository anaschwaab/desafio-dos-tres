defmodule Jogo do
  alias Tabuleiro
  alias Jogador
  alias Vitoria

  def start do
    tabuleiro = Tabuleiro.criar(4, 4)
    jogador_atual = 1
    historico_jogadas = %{}  # armazena a última jogada de cada jogador
    ultima_jogada_geral = nil

    loop_jogo(tabuleiro, jogador_atual, historico_jogadas, ultima_jogada_geral)
  end

  defp loop_jogo(tabuleiro, jogador_atual, historico_jogadas, ultima_jogada_geral) do
    if Vitoria.jogo_terminou?(tabuleiro) do
      vencedor = Vitoria.encontrar_vencedor(tabuleiro)
      IO.puts("Fim do jogo! O jogador #{vencedor} venceu!")
    else
      #Tabuleiro.exibir(tabuleiro)

      ultima_jogada_do_jogador = Map.get(historico_jogadas, jogador_atual, nil)

      {novo_tabuleiro, nova_jogada} =
        Jogador.realizar_jogada(tabuleiro, jogador_atual, ultima_jogada_do_jogador, ultima_jogada_geral)

      proximo_jogador = Jogador.proximo(jogador_atual)

      novo_historico =
        if nova_jogada do
          Map.put(historico_jogadas, jogador_atual, nova_jogada)
        else
          historico_jogadas
        end

      loop_jogo(novo_tabuleiro, proximo_jogador, novo_historico, nova_jogada)
    end
  end

end
