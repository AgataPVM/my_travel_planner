class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :title, :destination, :days, :people, :interest, presence: true
end
