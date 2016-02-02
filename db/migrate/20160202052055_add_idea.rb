class AddIdea < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :body
    end
  end
end
