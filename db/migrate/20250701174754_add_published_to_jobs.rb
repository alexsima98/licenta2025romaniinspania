class AddPublishedToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :published, :boolean, default: false, null: false
  end
end
