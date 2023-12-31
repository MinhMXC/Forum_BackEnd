class AddVisitedToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :visited, :boolean, null: false, default: false
  end
end
