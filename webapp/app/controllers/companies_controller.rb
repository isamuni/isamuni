class CompaniesController < PagesController
    def index
      @pages = Page.where(kind: 'company')
    end

    def show
    end

end
