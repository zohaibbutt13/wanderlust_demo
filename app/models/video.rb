class Video < ApplicationRecord
  has_many :projects_videos
  has_many :projects, through: :projects_videos

  has_one_attached :file

  validates :title, length: { in: 4..255 }
  validates :cost_in_cents, numericality: { greater_than: 0 }

  def cost_in_usd
    ::General::CurrencyConverterService.new(
      cost_in_cents,
      CENTS_CODE,
      USD_CURRENCY_CODE
    ).call
  end
end
