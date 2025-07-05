class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :footage_link
      t.integer :status
      t.references :client
      t.references :user

      t.timestamps
    end
  end
end
