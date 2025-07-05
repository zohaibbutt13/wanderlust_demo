module Clients
  class ListingService
    def initialize(params)
      @page = listing_params(params)[:page] || 1
    end

    def call
      Client.joins("LEFT JOIN projects ON clients.id = projects.client_id")
            .select("clients.*, COUNT(projects.id) AS projects_count")
            .group("clients.id")
            .paginate(page: @page, per_page: PER_PAGE)
    end

    private

    def listing_params(params)
      params.permit(:page)
    end
  end
end
