class AddTimeStampsToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :created_at, :timestamp
    add_column :ideas, :updated_at, :timestamp
  end
end
