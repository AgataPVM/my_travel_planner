class ItinerariesController < ApplicationController
  def index
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def itineraries_params
    params.require(:itinerary).permit(:content)
  end
end
