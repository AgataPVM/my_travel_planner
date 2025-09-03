class Itinerary < ApplicationRecord
  belongs_to :user

  validates :title, :destination, :days, :people, :interest, presence: true
end
