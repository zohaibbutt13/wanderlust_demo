module Projects
  class ListingService
    def initialize(current_client:, permitted_params:)
      @current_client = current_client
      @page = permitted_params[:page] || DEFAULT_PAGE
      @per_page = permitted_params[:per_page] || DEFAULT_PER_PAGE
    end

    def call
      current_client ? load_client_projects : load_all_projects
    end

    private

    attr_reader :current_client, :page, :per_page

    def load_client_projects
      current_client.projects.includes(:user, :videos).paginate(page: page, per_page: per_page)
    end

    def load_all_projects
      Project.all.includes(:user, :videos).paginate(page: page, per_page: per_page)
    end
  end
end
