class ItinerariesController < ApplicationController
  def index
  end

  def show
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

  def destroy
  end

  private

  def itineraries_params
  end


end
