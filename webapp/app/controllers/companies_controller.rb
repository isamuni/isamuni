class CompaniesController < PagesController
    def index
      @pages = Page.where(kind: Page::kinds[:company])
    end

    def show
    end

end
