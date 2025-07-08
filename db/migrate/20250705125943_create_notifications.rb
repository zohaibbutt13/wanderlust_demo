class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :notifier_type, null: false
      t.bigint :notifier_id, null: false
      t.integer :status, null: false, default: 1
      t.string :action, null: false
      t.text :payload, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :notifications, [ :notifier_type, :notifier_id ]
  end
end
