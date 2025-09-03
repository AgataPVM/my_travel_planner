class ItinerariesController < ApplicationController

  def index
    @itineraries = Itinerary.all
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def new

  end

  def create

  end

  def destroy
    @itinerary = Itineray.find(params[:id])
    @itinerary.destroy
    redirect_to itineraries_path, status: :see_other
  end

  private

  def itineraries_params
    params.require(:itinerary).permit(:content)
  end
end
