class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.integer :role

      t.timestamps
    end
  end
end
