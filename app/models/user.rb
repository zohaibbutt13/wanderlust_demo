class User < ApplicationRecord
  has_many :projects, dependent: :nullify
  has_many :notifications, dependent: :nullify

  validates :full_name, presence: true, length: { in: 4..255 }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :role, presence: true

  enum role: {
    user: 1,
    project_manager: 2
  }

  attribute :active, :boolean, default: true

  scope :active, -> { where(active: true) }
  scope :managers, -> { where(role: :project_manager) }

  def self.default_project_manager
    project_manager.first
  end
end
