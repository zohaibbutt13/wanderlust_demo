require 'rails_helper'

RSpec.describe Notifications::GenerationService, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:action) { "created" }
  let(:payload) { { "message" => "New project created" } }

  describe '#call' do
    context 'when valid inputs are provided' do
      it 'creates a notification' do
        service = Notifications::GenerationService.new(
          resource: project,
          action: action,
          user_id: user.id,
          payload: payload
        )

        expect { service.call }.to change { Notification.count }.by(1)

        notification = Notification.last
        expect(notification.user_id).to eq(user.id)
        expect(notification.notifier).to eq(project)
        expect(notification.action).to eq(action)
        expect(notification.status).to eq("pending")
        expect(notification.payload).to eq(payload)
      end
    end

    context 'when resource does not support polymorphic notifications' do
      it 'raises an ArgumentError' do
        invalid_resource = double("InvalidResource")

        service = Notifications::GenerationService.new(
          resource: invalid_resource,
          action: action,
          user_id: user.id,
          payload: payload
        )

        expect { service.call }.to raise_error(ArgumentError, "Notifier resource must support polymorphic notifications")
      end
    end

    context 'when user_id is missing' do
      it 'raises an ArgumentError' do
        service = Notifications::GenerationService.new(
          resource: project,
          action: action,
          user_id: nil,
          payload: payload
        )

        expect { service.call }.to raise_error(ArgumentError, "User ID is required")
      end
    end

    context 'when action is missing' do
      it 'raises an ArgumentError' do
        service = Notifications::GenerationService.new(
          resource: project,
          action: nil,
          user_id: user.id,
          payload: payload
        )

        expect { service.call }.to raise_error(ArgumentError, "Action is required")
      end
    end
  end
end
