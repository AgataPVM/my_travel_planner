class ItinerariesController < ApplicationController

  def index
    @itineraries = Itinerary.all
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itineraries_params)
    if @itinerary.save
      redirect_to @itinerary
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @itinerary = Itineray.find(params[:id])
    @itinerary.destroy
    redirect_to itineraries_path, status: :see_other
  end

  private

  def itineraries_params
    params.require(:itinerary).permit(:title, :destination, :days, :people, :interest)
  end
end
