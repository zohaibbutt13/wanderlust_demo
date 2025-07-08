class Client < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :full_name, presence: true, length: { minimum: 4, maximum: 255 }
  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  scope :with_projects_count, -> {
    left_joins(:projects)
      .select("clients.*, COUNT(projects.id) AS projects_count")
      .group("clients.id")
  }
end
