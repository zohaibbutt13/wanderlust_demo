class Client < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :full_name, length: { in: 4..255 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
