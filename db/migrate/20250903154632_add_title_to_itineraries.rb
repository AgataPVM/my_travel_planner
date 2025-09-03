class AddTitleToItineraries < ActiveRecord::Migration[7.1]
  def change
    add_column :itineraries, :title, :string
  end
end
