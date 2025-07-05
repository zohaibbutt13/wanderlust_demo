class User < ApplicationRecord
  has_many :projects
  has_many :notifications, dependent: :nullify

  validates :full_name, length: { in: 4..255 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: [ "user", "project_manager" ] }

  enum role: {
    user: 1,
    project_manager: 2
  }

  def self.default_project_manager
    self.where(role: 2).first
  end
end
