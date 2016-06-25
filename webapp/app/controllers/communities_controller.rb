class CommunitiesController < PagesController
  def index
    @pages = Page.where(kind: 'community')
  end

  def show
  end
end
