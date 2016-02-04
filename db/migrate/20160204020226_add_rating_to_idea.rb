class AddRatingToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :rating, :integer, default: 0
  end
end
