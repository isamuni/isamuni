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
  },
  {
    uid: "789",
    name: "CatCat",
    description: "I'm a cat, I know **python**",
    occupation: "student at josh's place",
    projects: "purr.js, catNamer.js",
    links: "my website: http://www.example.com"
  },
  {
    uid: "1097",
    name: "Simone Ivan Conte",
    description: "#### Educazione e Ricerca
Sono un dottorando (secondo anno) in informatica alla University of St Andrews, sotto la supervisione del Prof. Alan Dearle e il Dr. Graham Kirby. La mia ricerca consiste nello studiare e sviluppare nuove tecniche per la gestione e distribuzione di dati in quello da noi chiamato: Sea Of Stuff. La mia ricerca è sponsorizzata da EPSRC e Adobe Systems Inc.

Ho una laurea in Informatica sempre presso la University of St Andrews (2010-2014), e un diploma IB presso lo United World College in Mostar (2008-2010).

My research interests include distributed systems, data models, data science, open data, provenance, storage and software engineering.

Sono stato membro del gruppo di ricerca SACHI (2012-2014).

#### Altro
Nel 2014 sono diventato sviluppatore di NOMAD, una spin-off che si occupa della gestione di dati generati da spettrometri NMR. Sono poi diventato lead developer del progetto. Nel 2016 mi sono brevemente distaccato da NOMAD per ritornare come consultant nel team. Da Maggio sono temporaneamente il CTO di NOMAD.

Nel 2013 ho creato PAC - Programmatori a Catania - una community digitale si programmatori, designers e appassionati e professionisti del settore tech a Catania e dintorni.

Sono stato a capo dell'organizzazione di [PAC15](http://pac15.github.io/).

Nel 2016 la comunità di PAC ha lanciato il primo progetto satellite: [awesome-sicily](https://github.com/sic2/awesome-sicily)

#### Altro ancora
Mi piace leggere, scrivere, fare [foto](https://500px.com/sic2), cucinare e tantissimo altro ancora :)",
    occupation: "Dottorando, Programmatore",
    projects: "#### Open Source
- [awesome-sicily](https://github.com/sic2/awesome-sicily)
- [isamuni](https://github.com/sic2/isamuni)

#### Altro
- NOMAD",
    links: "- https://sic2.host.cs.st-andrews.ac.uk/
- https://uk.linkedin.com/in/simoneivanconte"
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
    user: users.first,
    active: true
  },
  {
    name: "CactusCorp",
    kind: Page::kinds[:company],
    location: "Catania, via cactus 3",
    lookingfor: "Linux cactuses and humans!",
    links: "fbpage: http://facebook.com",
    contacts: "cactuscorps@gmail.com",
    user: users.first,
    active: true
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
    created_at: "2010-06-06 09:08:24.000000"
  },
  {
    uid: "def",
    author_name: "Cactus1",
    author_uid: "123",
    link: "fbpost: http://facebook.com",
    content: "This is a job offer",
    tags: "job",
    post_type: "status",
    created_at: "2010-06-12 19:16:24.000000"
  },
  {
    uid: "ghi",
    author_name: "LonelyCat2",
    author_uid: "1097",
    link: "fbpost: http://facebook.com",
    content: "This is an event post",
    post_type: "event",
    created_at: "2010-06-12 19:16:24.000000"
  }

  ])
