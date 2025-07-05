class Notification < ApplicationRecord
  belongs_to :user

  validates :title, length: { in: 4..255 }
  validates :status, inclusion: { in: [ "pending", "in_progress", "failed", "succeeded" ] }

  enum status: {
    pending: 1,
    in_progress: 2,
    failed: 3,
    succeeded: 4
  }
end
