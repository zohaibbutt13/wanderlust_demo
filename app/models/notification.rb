class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifier, polymorphic: true

  validates :status, inclusion: { in: [ "pending", "in_progress", "failed", "succeeded" ] }

  serialize :payload, coder: JSON

  enum status: {
    pending: 1,
    in_progress: 2,
    failed: 3,
    succeeded: 4
  }
end
