class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.jsonb :participation_rules

      t.timestamps
    end
  end
end
