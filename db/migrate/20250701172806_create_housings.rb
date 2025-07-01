class CreateHousings < ActiveRecord::Migration[8.0]
  def change
    create_table :housings do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
