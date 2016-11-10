class Post < ApplicationRecord
  belongs_to :source, optional: true

  Job_tags = ['#lavoro', '#jobs', '#job', '#cercosocio', '[job]', '[jobs]']

  def self.from_fb_post feed_post
    post = Post.new()
    post.uid = feed_post['id']
    post.content = feed_post['message']
    post.author_name = feed_post['from']['name']
    post.author_uid = feed_post['from']['id']
    post.created_at = feed_post['created_time']
    post.updated_at = feed_post['updated_time']
    post.post_type = feed_post['type']
    post.caption = feed_post['caption']
    post.description = feed_post['description']
    post.name = feed_post['name']

    if feed_post['link'] != nil
      post.link = feed_post['link']
    end

    if feed_post['picture'] != nil
      post.picture = feed_post['picture']
    end

    if post.content != nil
      jobs = Job_tags.any? { |word| post.content.downcase.include?(word) }
      if jobs
        post.tags = 'job' # Improve?
      end
    end

    # Show post by default
    post.show = true

    post
  end

  def self.only_jobs
    where(:tags => 'job')
  end

  # Get date (yyyy-mm-dd) of the latest post in the db
  def self.last_post_date 
    last_post_date = maximum(:created_at)
    if last_post_date
      last_post_date.strftime("%Y-%m-%d")
    else
      nil
    end
  end

  def facebook_link
    if post_type == "event"
      nil
    else
      'https://www.facebook.com/' + uid
    end
  end

  def alt
    if name?
      name
    else
      content[0..40]
    end
  end

  def as_json(options={})
    super(only: [:name, :content, :link, :author_name, :post_type, :created_at])
  end

end
