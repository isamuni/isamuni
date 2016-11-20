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

    post.likes_count = feed_post['likes']['summary']['total_count']
    post.comments_count = feed_post['comments']['summary']['total_count']

    if feed_post['shares'] != nil
      post.shares_count = feed_post['shares']['count']
    else
      post.shares_count = 0
    end

    # Show post by default
    post.show = true

    post
  end

  def self.only_jobs
    where(:tags => 'job')
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
