class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.integer :role, null: false, default: 1
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :role
    add_index :users, :active
  end
end
