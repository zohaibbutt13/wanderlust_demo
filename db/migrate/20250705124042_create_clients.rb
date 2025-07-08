class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :full_name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :clients, :email, unique: true
  end
end
