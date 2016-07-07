class HomeController < ApplicationController

  def index
  	@posts = Post.limit(10).order('created_at desc')
  	@posts_jobs = Post.where(tags: 'job').limit(5).order('created_at desc')

  end


  def data
  	posts = Post.order('created_at desc')

  	respond_to do |format|
      format.json { render json: posts.map { |post| {:id => post.uid, :author_name => post.author_name,:type => post.post_type,:created_at => post.created_at} } }
    end
  end

end
