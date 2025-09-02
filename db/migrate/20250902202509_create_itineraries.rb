class CreateItineraries < ActiveRecord::Migration[7.1]
  def change
    create_table :itineraries do |t|
      t.string :content

      t.timestamps
    end
  end
end
