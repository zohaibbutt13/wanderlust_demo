require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "associations" do
    it { should have_many(:projects_videos) }
    it { should have_many(:projects).through(:projects_videos) }
    it { should have_one_attached(:file) }
  end

  describe "validations" do
    it { should validate_length_of(:title).is_at_least(4).is_at_most(255) }
  end
end
