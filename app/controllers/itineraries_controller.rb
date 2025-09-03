class ItinerariesController < ApplicationController
  def index
  end

  def show
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

  def itinerary_params
  end


end
