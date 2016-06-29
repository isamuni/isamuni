class HomeController < ApplicationController

  def index
  	@posts = Post.limit(10).order('created_at desc')
  	@posts_jobs = Post.where(tags: 'job').limit(5).order('created_at desc')
  end
end
