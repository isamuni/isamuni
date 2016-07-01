class EventsController < ApplicationController

def index
    @events = Post.where(post_type: 'event').limit(100).order('created_at desc')
  end

end