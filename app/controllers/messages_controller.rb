class MessagesController < ApplicationController
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @message = Message.new(message_params)
    @message.role = "user"
    @message.itinerary = @itinerary
    if @message.save
      build_conversation_history
      @response = @ruby_llm_itinerary.with_instructions(instructions).ask(@message.content)
      Message.create(role: "assistant", content: @response.content, itinerary: @itinerary)
      redirect_to itinerary_path(@itinerary)
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
