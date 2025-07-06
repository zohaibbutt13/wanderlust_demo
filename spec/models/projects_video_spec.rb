require 'rails_helper'

RSpec.describe ProjectsVideo, type: :model do
  describe "associations" do
    it { should belong_to(:project) }
    it { should belong_to(:video) }
  end
end
