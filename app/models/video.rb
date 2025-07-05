class Video < ApplicationRecord
  has_many :projects_videos
  has_many :projects, through: :projects_videos

  has_one_attached :file

  validates :title, length: { in: 4..255 }
end
