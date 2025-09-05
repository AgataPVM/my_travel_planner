class MessagesController < ApplicationController
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @message   = @itinerary.messages.build(message_params.merge(role: "user"))

    if @message.save
      build_conversation_history
      assistant_content   = @ruby_llm_itinerary.with_instructions(instructions).ask(@message.content).content
      @assistant_message  = @itinerary.messages.create!(role: "assistant", content: assistant_content)

      respond_to do |format|
        # fluxo normal Turbo (sem redirect, sem pulo pro topo)
        format.turbo_stream

        # fallback: mesmo se o request vier como HTML, ainda respondemos com turbo stream
        format.html do
          render turbo_stream: [
            turbo_stream.append("messages",
              partial: "messages/messages",
              locals: { messages: [@message, @assistant_message] }),
            turbo_stream.replace("new_message",
              partial: "messages/form",
              locals: { itinerary: @itinerary, message: Message.new })
          ]
        end
      end
    else
      render "itineraries/show", status: :unprocessable_entity
    end
  end

  private

  def build_conversation_history
    @ruby_llm_itinerary = RubyLLM.chat
    @itinerary.messages.each do |message|
    @ruby_llm_itinerary.add_message(role: message.role, content: message.content)
    end
  end

  def instructions
    "Considere esse roteiro de viagem: #{@itinerary.content}"
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
