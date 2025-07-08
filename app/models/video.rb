class Video < ApplicationRecord
  has_many :projects_videos
  has_many :projects, through: :projects_videos

  has_one_attached :file

  validates :title, length: { in: 4..255 }
  validates :cost_in_cents, numericality: { greater_than: 0 }
  validate :acceptable_file

  attribute :active, :boolean, default: true

  scope :active, -> { where(active: true) }

  def cost_in_usd
    ::General::CurrencyConverterService.new(
      cost_in_cents,
      CENTS_CODE,
      USD_CURRENCY_CODE
    ).call
  end

  private

  def acceptable_file
    return unless file.attached?

    unless file.content_type.in?(%w[video/mp4 video/mov video/webm])
      errors.add(:file, "must be a valid video format")
    end

    if file.byte_size > 100.megabytes
      errors.add(:file, "is too big (maximum is 100MB)")
    end
  end
end
