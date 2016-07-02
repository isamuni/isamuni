# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  {
   name: "Cactus1",
   description: "hey, I can code in C++",
   occupation: "student at succulents school",
   projects: "watering++",
   links: "my website: http://www.example.com"
 },
 {
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
