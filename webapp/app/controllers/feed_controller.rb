class FeedController < ApplicationController

	MAX_NUMBER_OF_POSTS = 50
	MAX_NUMBER_OF_JOB_POSTS = 20

	def index
	  	@posts = Post.where(:show => true).limit(MAX_NUMBER_OF_POSTS).order('created_at desc')
	  	@posts_jobs = Post.only_jobs.where(:show => true).limit(MAX_NUMBER_OF_JOB_POSTS).order('created_at desc')

	  	respond_to do |format|
	        format.html { render :index }

					@posts = @posts.paginate page: params[:page]
	        format.json { render json: paginated_json(@posts)}
    	end
  end

  	def sources
  		counts = Post.group(:source_id).count

  		sources = Source.find(counts.keys).map { |e|
  			e.as_json.merge({count: counts[e.id]})
  		}

  		render json: sources
  	end

	def posts

			@posts = Post
			unless params[:limit].to_i == 0
				@posts = @posts.limit(params[:limit].to_i)
			end

			@posts = @posts.order('created_at desc')
							.includes(:source)
							.includes(:author)

	    if params[:jobs_only] == "true"
	    	@posts = @posts.only_jobs
	    end

	    unless params[:start].blank? or params[:end].blank?
        start_time = Time.at(params[:start].to_i / 1000.0)
        end_time = Time.at(params[:end].to_i / 1000.0)
	    	@posts = @posts.where(:created_at => start_time..end_time)
	    end

	    unless params[:sources].blank?
	    	source_ids = params[:sources].split(",").map(&:to_i)
	    	@posts = @posts.where(source_id: source_ids)
      end

      unless params[:author].blank?
        @posts = @posts.where(author_uid: params[:author])
      end

	  	respond_to do |format|
	        format.html { render partial: "posts", :posts => @posts }
	        format.json {
	        	posts_data = @posts.map do |post|
              post
                .as_json(only: [:author_name, :link, :content, :post_type, :name, :source_id, :caption, :description])
                .merge({
    							post_link: post.facebook_link,
                  author_link: post.author == nil ? nil : user_path(post.author),
    					    created_at: post.created_at.to_f * 1000,
    					    picture: post.picture || post&.author&.profile_pic(90) || post&.author_pic(90) || nil,
    							likes: post.likes_count,
    							comments: post.comments_count,
    							shares: post.shares_count
					      })
	        	end
	        	render json: posts_data
	        }
    	end

  	end

  	def data
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
	      "rows": posts
	    }

	  	respond_to do |format|
	      format.json { render json: datatable }
	    end
	  end
end
