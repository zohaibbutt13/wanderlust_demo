module Projects
  class CreationService
    class Response
      attr_reader :project, :message

      def initialize(success:, project: nil, message:)
        @success = success
        @project = project
        @message = message
      end

      def success?
        @success
      end
    end

    def initialize(current_client:, permitted_params:)
      @current_client = current_client
      @permitted_params = permitted_params
    end

    def call
      return failure(nil, "Please select at least one video") if permitted_params[:video_ids].blank?

      project = nil

      ActiveRecord::Base.transaction do
        project = current_client.projects.create!(
          title: permitted_params[:title],
          footage_link: permitted_params[:footage_link],
          status: :pending,
          user: User.default_project_manager
        )

        ::Projects::LinkVideosService.new(project: project, video_ids: permitted_params[:video_ids]).call
      end

      enqueue_notification(project)

      success(project, "Project created successfully")
    rescue ActiveRecord::RecordInvalid => e
      failure(project, e.record.errors.full_messages.to_sentence)
    rescue StandardError => e
      Rails.logger.error("Project creation failed: #{e.message}\n#{e.backtrace.join('\n')}")
      failure(project, "Something went wrong while creating the project")
    end

    private

    attr_reader :current_client, :permitted_params

    def enqueue_notification(project)
      ::NotificationGenerationWorker.perform_async(notification_payload(project).to_json)
    end

    def notification_payload(project)
      {
        resource_name: project.class.name,
        resource_id: project.id,
        action: :create,
        user_id: project.user_id,
        payload: {}
      }
    end

    def success(project, message)
      Response.new(success: true, project: project, message: message)
    end

    def failure(project, message)
      Response.new(success: false, project: project, message: message)
    end
  end
end
