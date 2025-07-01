class AddPublishedToHousings < ActiveRecord::Migration[8.0]
  def change
    add_column :housings, :published, :boolean, default: false, null: false
  end
end
