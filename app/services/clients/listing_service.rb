# app/services/clients/listing_service.rb
module Clients
  class ListingService
    def initialize(page: DEFAULT_PAGE, per_page: DEFAULT_PER_PAGE)
      @page = page.presence || DEFAULT_PAGE
      @per_page = per_page
    end

    def call
      Client.with_projects_count.paginate(page: page, per_page: per_page)
    end

    private

    attr_reader :page, :per_page
  end
end
