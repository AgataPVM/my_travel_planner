class AddFieldsToItinerary < ActiveRecord::Migration[7.1]
  def change
    add_column :itineraries, :destination, :string
    add_column :itineraries, :days, :integer
    add_column :itineraries, :people, :integer
    add_column :itineraries, :interest, :text
  end
end
