class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :notifier_type
      t.bigint :notifier_id
      t.integer :status
      t.string :action
      t.text :payload
      t.references :user

      t.timestamps
    end
  end
end
