class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.belongs_to :organization, null: false, foreign_key: true
      t.string :report_type

      t.timestamps
    end
  end
end
