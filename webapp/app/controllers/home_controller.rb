class HomeController < ApplicationController

  def index
  	@posts = Post.limit(30).order('created_at desc')
  	@posts_jobs = Post.where(tags: 'job').limit(30).order('created_at desc')

  end

  def data
    posts = Post.select("date(created_at) as created_at").group("date(created_at)").order('created_at desc').distinct.count(:uid)

    # String are concatenated using .concat which is magnitute of times faster than +
    posts = posts.map { |post| {:c => [
      {:v => 
        'Date('
        .concat(
          post[0][0..3] # year
          .concat(', ')
          .concat((post[0][5..6].to_i - 1).to_s) # month (0-based)
          .concat(', ')
          .concat(post[0][8..9])
          )
        .concat(')')},
      {:v => post[1]}
      ]} }

   
    datatable = {
      "cols": 
        [{'id': '', 'label': 'day', 'type': 'date'},
        {'id': '', 'label': 'posts', 'type': 'number'}],  
      "rows":
      posts
    }

  	respond_to do |format|
      format.json { render json: datatable }
    end
  end

  def posts
    start_time = Time.at(params[:start].to_i / 1000.0)
    end_time = Time.at(params[:end].to_i / 1000.0)
    
    @posts = Post.where(:created_at => start_time..end_time)
            .limit(30).order('created_at desc')
    render partial: "posts", :posts => @posts
  end

end
