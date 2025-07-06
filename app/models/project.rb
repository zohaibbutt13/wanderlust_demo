class Project < ApplicationRecord
  has_many :projects_videos, dependent: :destroy
  has_many :videos, through: :projects_videos
  has_many :notifications, as: :notifier
  belongs_to :user
  belongs_to :client

  validates :title, length: { in: 4..255 }
  validates :status, inclusion: { in: [ "pending", "in_progress", "completed" ] }
  validate :valid_footage_url?

  after_create_commit :generate_notification

  enum status: {
    pending: 1,
    in_progress: 2,
    completed: 3
  }

  private

  def valid_footage_url?
    uri = URI.parse(footage_link)

    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      raise URI::InvalidURIError
    end
  rescue URI::InvalidURIError
    errors.add(:footage_link, "is not a valid url")
  end

  def generate_notification
    ::NotificationGenerationWorker.perform_async(
      {
        resource_name: self.class.name,
        resource_id: self.id,
        action: :create,
        user_id: self.user_id,
        payload: {}
      }.to_json
    )
  end
end
