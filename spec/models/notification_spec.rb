require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:notifier) }
  end

  describe 'enums' do
    it do
      should define_enum_for(:status)
        .with_values(pending: 1, in_progress: 2, failed: 3, succeeded: 4)
    end
  end
end
