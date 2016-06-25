class CommunitiesController < PagesController
  def index
    @pages = Page.where(kind: Page::kinds[:community])
  end

  def show
  end
end
