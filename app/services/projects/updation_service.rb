module Projects
  class UpdationService
    class Response
      attr_reader :project, :message

      def initialize(success:, project: nil, message:)
        @project = project
        @success = success
        @message = message
      end

      def success?
        @success
      end
    end

    def initialize(project:, permitted_params:)
      @project = project
      @permitted_params = permitted_params
    end

    def call
      project.update!(update_hash)
      Response.new(success: true, project: project, message: "Project updated successfully")
    rescue ActiveRecord::RecordInvalid => e
      Response.new(success: false, project: nil, message: e.record.errors.full_messages.to_sentence)
    rescue => e
      Rails.logger.error("Project update failed: #{e.message}\n#{e.backtrace.join('\n')}")
      Response.new(success: false, project: nil, message: "Something went wrong while updating the project")
    end

    private

    attr_reader :project, :permitted_params

    def update_hash
      permitted_params.slice(:status)
    end
  end
end
