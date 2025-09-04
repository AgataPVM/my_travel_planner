class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :messages

  validates :title, :destination, :days, :people, :interest, presence: true
end
