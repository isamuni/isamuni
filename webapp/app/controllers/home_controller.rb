class HomeController < ApplicationController

  def index
  	@posts = Post.limit(10).order('created_at desc')
  	@posts_jobs = Post.where(tags: 'job').limit(5).order('created_at desc')

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

end


# {
#   cols: [{id: 'A', label: 'NEW A', type: 'string'},
#          {id: 'B', label: 'B-label', type: 'number'},
#          {id: 'C', label: 'C-label', type: 'date'}
#   ],
#   rows: [{c:[{v: 'a'},
#              {v: 1.0, f: 'One'},
#              {v: new Date(2008, 1, 28, 0, 31, 26), f: '2/28/08 12:31 AM'}
#         ]},
#          {c:[{v: 'b'},
#              {v: 2.0, f: 'Two'},
#              {v: new Date(2008, 2, 30, 0, 31, 26), f: '3/30/08 12:31 AM'}
#         ]},
#          {c:[{v: 'c'},
#              {v: 3.0, f: 'Three'},
#              {v: new Date(2008, 3, 30, 0, 31, 26), f: '4/30/08 12:31 AM'}
#         ]}
#   ],
#   p: {foo: 'hello', bar: 'world!'}
# }