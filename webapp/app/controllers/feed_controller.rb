# frozen_string_literal: true
class FeedController < ApplicationController
  MAX_NUMBER_OF_POSTS = 50
  MAX_NUMBER_OF_JOB_POSTS = 20

  def index
    @posts = Post.where(show: true).limit(MAX_NUMBER_OF_POSTS).order('created_at desc')
    @posts_jobs = Post.only_jobs.where(show: true).limit(MAX_NUMBER_OF_JOB_POSTS).order('created_at desc')

    respond_to do |format|
      format.html { render :index }

      @posts = @posts.paginate page: params[:page]
      format.json { render json: paginated_json(@posts) }
    end
  end

  def sources
    counts = Post.group(:source_id).count

    sources = Source.where(id: counts.keys).map do |e|
      e.as_json.merge(count: counts[e.id])
    end

    render json: sources
  end

  def posts

    post_limit = if params[:limit].blank?
      MAX_NUMBER_OF_POSTS
    elsif params[:limit].to_i == 0
      10000
    else
      params[:limit].to_i
    end

    @posts = Post.limit(post_limit)

    @posts = @posts.order('created_at desc')
                   .includes(:source)
                   .includes(:author)

    @posts = @posts.only_jobs if params[:jobs_only] == 'true'

    unless params[:start].blank? || params[:end].blank?
      start_time = Time.at(params[:start].to_i / 1000.0)
      end_time = Time.at(params[:end].to_i / 1000.0)
      @posts = @posts.where(created_at: start_time..end_time)
    end

    unless params[:sources].blank?
      source_ids = params[:sources].split(',').map(&:to_i)
      @posts = @posts.where(source_id: source_ids)
    end

    unless params[:author].blank?
      @posts = @posts.where(author_uid: params[:author])
    end

    respond_to do |format|
      format.html { render partial: 'posts', posts: @posts }
      format.json do
        posts_data = @posts.map do |post|
          post
            .as_json(only: [:author_name, :link, :content, :post_type, :name, :source_id, :caption, :description])
            .merge(post_link: post.facebook_link,
                   author_link: post.author.nil? ? nil : user_path(post.author),
                   created_at: post.created_at.to_f * 1000,
                   picture: post.picture || post&.author&.profile_pic(90) || post&.author_pic(90) || nil,
                   likes: post.likes_count,
                   comments: post.comments_count,
                   shares: post.shares_count)
        end
        render json: posts_data
      end
    end
    end

  def data
    date_count = Post.group('date(created_at)')
                     .order('date(created_at) desc')
                     .distinct.count(:uid)

    posts = date_count.map do |date, count|
      { c: [
        { v: to_js_date(date) },
        { v: count }
      ] }
    end

    datatable = {
      "cols":
        [{ 'id': '', 'label': 'day', 'type': 'date' },
         { 'id': '', 'label': 'posts', 'type': 'number' }],
      "rows": posts
    }

    respond_to do |format|
      format.json { render json: datatable }
    end
  end
end
