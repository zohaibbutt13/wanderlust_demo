class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.references :user

      t.timestamps
    end
  end
end
