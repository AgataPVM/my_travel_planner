class AddUserToItinerary < ActiveRecord::Migration[7.1]
  def change
    add_reference :itineraries, :user, null: false, foreign_key: true
  end
end
