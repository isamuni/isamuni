class HomeController < ApplicationController

  def index
  	@posts = Post.limit(10).order('created_at desc')

  end
end
