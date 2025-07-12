class CreateSpaces < ActiveRecord::Migration[8.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.belongs_to :organization, null: false, foreign_key: true
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
