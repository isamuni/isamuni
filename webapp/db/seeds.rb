# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  {
    uid: "123",
    name: "Cactus1",
    description: "hey, I can code in C++",
    occupation: "student at succulents school",
    projects: "watering++",
    links: "my website: http://www.example.com"
 },
 {
    uid: "456",
    name: "LonelyCat2",
    description: "I'm a cat, I know ruby",
    occupation: "student at josh's place",
    projects: "purr.js, catNamer.js",
    links: "my website: http://www.example.com"
 }
  ])

pages = Page.create([
  {
    name: "CactusSchool LUG",
    kind: Page::kinds[:community],
    location: "Catania, via cactus 3",
    lookingfor: "Linux-passionate cactuses and humans!",
    links: "fbpage: http://facebook.com",
    contacts: "imacactus@gmail.com",
    user: users.first
  }
  ])

posts = Post.create([
  {
    uid: "abc",
    author_name: "Cactus1",
    author_uid: "123",
    link: "fbpost: http://facebook.com",
    content: "Hi guys! I am trying to learn a new programming language. I already know C++, Java and Python. What do you suggest me to learn next?",
    post_type: "status",
    created_at: "2016-06-06 09:08:24.000000"
  },
  {
    uid: "def",
    author_name: "Cactus1",
    author_uid: "123",
    link: "fbpost: http://facebook.com",
    content: "This is a job offer",
    tags: "job",
    post_type: "status",
    created_at: "2016-06-12 19:16:24.000000"
  },
  {
    uid: "ghi",
    author_name: "LonelyCat2",
    author_uid: "456",
    link: "fbpost: http://facebook.com",
    content: "This is an event post",
    post_type: "event",
    created_at: "2016-06-12 19:16:24.000000"
  }
  
  ])
  
