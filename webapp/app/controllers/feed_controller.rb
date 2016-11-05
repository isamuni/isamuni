class FeedController < ApplicationController

	MAX_NUMBER_OF_POSTS = 50
	MAX_NUMBER_OF_JOB_POSTS = 20

	def index
	  	@posts = Post.where(:show => true).limit(MAX_NUMBER_OF_POSTS).order('created_at desc')
	  	@posts_jobs = Post.only_jobs.where(:show => true).limit(MAX_NUMBER_OF_JOB_POSTS).order('created_at desc')

	  	respond_to do |format|
	        format.html { render :index }
	        format.json { render json: @posts }
    	end
  	end

	def posts
	    start_time = Time.at(params[:start].to_i / 1000.0)
	    end_time = Time.at(params[:end].to_i / 1000.0)

	    @posts = Post.where(:created_at => start_time..end_time)
	                 .limit(MAX_NUMBER_OF_POSTS)
	                 .order('created_at desc')

	    render partial: "posts", :posts => @posts
  	end



  	def data

  		# warning, date() in sqlite returns a string, but in postgres it returns a Date
	    date_count = Post.group("date(created_at)")
	    	.order('date(created_at) desc')
	    	.distinct.count(:uid)

	    posts = date_count.map do |date,count|    	
	     {:c => [
	      {:v => to_js_date(date) },
	      {:v => count}]}
	  	end

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
end