module Projects
  class UpdationService
    def initialize(project, params)
      @project = project
      @permitted_params = permitted_params(params)
    end

    def call
      @project.update!(update_hash)

      [ true, "Project updated successfully" ]
    rescue ActiveRecord::RecordInvalid => e
      [ false, e.message ]
    end

    private

    def update_hash
      { status: @permitted_params[:status] }
    end

    def permitted_params(params)
      params.require(:project).permit(:status)
    end
  end
end
