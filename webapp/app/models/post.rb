# frozen_string_literal: true
class Post < ApplicationRecord
  belongs_to :source, optional: true
  belongs_to :author,
             class_name: 'User',
             optional: true,
             foreign_key: 'author_uid',
             primary_key: 'uid'

  def self.only_jobs
    where(tags: 'job')
  end

  def facebook_link
    if post_type == 'event'
      nil
    else
      'https://www.facebook.com/' + uid
    end
  end

  def alt
    if name?
      name
    elsif content
      content[0..40]
    else
      ''
    end
  end

  def author_pic(height = '')
    height = '?height=' + height.to_s unless height == ''
    'http://graph.facebook.com/' + author_uid + '/picture' + height
  end

  def as_json(options = {})
    if options
      super(options)
    else
      super(only: [:name, :content, :link, :author_name, :post_type, :created_at])
    end
  end
end
