class AddDescriptionToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :description, :text
  end
end
