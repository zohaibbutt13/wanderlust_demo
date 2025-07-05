module Projects
  class ListingService
    def initialize(client, params)
      @client = client
      @page = listing_params(params)[:page] || 1
    end

    def call
      if @client
        load_client_projects
      else
        load_all_projects
      end
    end

    private

    def load_client_projects
      @client.projects.includes(:user, :videos).paginate(page: @page, per_page: PER_PAGE)
    end

    def load_all_projects
      Project.all.includes(:user, :videos).paginate(page: @page, per_page: PER_PAGE)
    end

    def listing_params(params)
      params.permit(:page)
    end
  end
end
