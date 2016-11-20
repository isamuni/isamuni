require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "author existing" do
     p = posts(:one)
     a = users(:one)

     a.uid = "abcde"
     p.author_uid = a.uid

     a.save!
     p.save!

     assert p.author == a
  end

  test "author not in db" do
     p = posts(:one)
     p.author_uid = "nonexistent"
     p.save!

     assert p.author.nil?
  end
  
end
