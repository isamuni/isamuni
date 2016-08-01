class Post < ApplicationRecord
  Job_tags = ['#lavoro', '#jobs', '#job', '#cercosocio']

  def self.from_fb_post feed_post
    post = Post.new()
    post.uid = feed_post['id']
    post.content = feed_post['message']
    post.author_name = feed_post['from']['name']
    post.author_uid = feed_post['from']['id']
    post.created_at = feed_post['created_time']
    post.updated_at = feed_post['updated_time']
    post.post_type = feed_post['type']
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

    post
  end

  # Get date (yyyy-mm-dd) of the latest post in the db
  def self.last_post_date
    last_post_date = Post.maximum(:created_at)
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

end
