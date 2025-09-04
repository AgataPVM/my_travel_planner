class ItinerariesController < ApplicationController
  def index
    @itineraries = current_user.itineraries
  end

  def show
    @itinerary = Itinerary.find(params[:id])
    @message = Message.new
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itineraries_params)

    prompt = <<-PROMPT
    Você é um Assistente de Roteiros de Viagem e sua especialidade é criar planos práticos e personalizados.

    Eu sou um viajante buscando sua ajuda para organizar minha próxima viagem.

    *Minha Solicitação:*
    Crie um roteiro de viagem de #{@itinerary.days} dias para #{@itinerary.destination}. A viagem será feita por #{@itinerary.people} pessoas que têm interesse em #{@itinerary.interest}.

    *Instruções para a sua resposta:*
      •⁠  ⁠*Direto ao Ponto:* Comece a resposta diretamente com o título do roteiro (ex: ‘Roteiro de X dias em [Destino]’). Não use frases introdutórias, saudações ou qualquer texto antes do início do itinerário.
      •⁠  ⁠*Formato:* Use markdown para estruturar o roteiro, com títulos para cada dia (ex: *Dia 1: Chegada e Exploração Inicial*).
      •⁠  ⁠*Conteúdo:* Para cada dia, sugira atrações principais, atividades e possíveis restaurantes. Inclua dicas locais úteis e sugestões de horários para otimizar o tempo.
      •⁠  ⁠*Tom:* Seja um guia amigável e eficiente. Ofereça um plano equilibrado, sem sobrecarregar o dia com excesso de opções. O objetivo é um roteiro prático e agradável.
    PROMPT


    @itinerary.user = current_user
    @itinerary.content = RubyLLM.chat.ask(prompt).content
    if @itinerary.save
      redirect_to @itinerary
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @itinerary = Itinerary.find(params[:id])
    @itinerary.destroy
    redirect_to itineraries_path, status: :see_other
  end

  private

  def itineraries_params
    params.require(:itinerary).permit(:title, :destination, :days, :people, :interest)
  end
end
