class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.date :date_of_birth
      t.boolean :parental_consent
      t.string :consent_token

      t.timestamps
    end
  end
end
