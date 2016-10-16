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
    links: "my website: http://www.example.com",
    tags: "c++, c, java"
  },
  {
    uid: "456",
    name: "LonelyCat2",
    description: "I'm a cat, I know ruby",
    occupation: "student at josh's place",
    projects: "purr.js, catNamer.js",
    links: "my website: http://www.example.com",
    tags: "c++, js, nodejs"
  },
  {
    uid: "789",
    name: "CatCat",
    description: "I'm a cat, I know **python**",
    occupation: "student at josh's place",
    projects: "purr.js, catNamer.js",
    links: "my website: http://www.example.com",
    tags: "javascript, node"
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
    name: "PAC - Programmatori a Catania",
    kind: Page::kinds[:community],
    location: "Catania",
    links: "https://www.facebook.com/groups/programmatoriCatania/",
    contacts: "
* Simone Iva Conte
* Gabriele Viglianisi
* Giuseppe Parasiliti
    ",
    user: users.first,
    active: true,
    description: "PAC - Programmatori a Catania - é un gruppo Facebook no-profit nato nel 2013 da un gruppo di amici appassionati d'Informatica e ora conta piú di 900 membri che ogni giorno promuovono idee e discutono problemi informatici. 

Nell'Ottobre 2015 abbiamo organizzato PAC15, il primo evento PAC per PAC. Tutte le info sull'evento sul sito: http://pac15.github.io/

Nel 2016 abbiamo deciso di concentrare le nostre forze nella creazione di progetti Open Source rivolti alla comunita' Siciliana. **Isamuni** è uno di questi progetti, ma non l'unico: https://sic2.github.io/pac/

Seguiteci anche su Twitter - [@DevsCT](https://twitter.com/DevsCT )"
  },
  {
    name: "CactusCorp",
    kind: Page::kinds[:company],
    location: "Catania, via cactus 3",
    lookingfor: "Sviluppatori C++ e C# , Project Managers e Designers",
    description: "CactusCorp nasce nel 2009 dall'esperienza pluriennale di un gruppo di professionisti 
    che operano da anni in Sicilia nel settore dell'Information Tecnology.

CactusCorp si propone come azienda qualificata nella consulenza, progettazione e realizzazione di progetti informatici 
legati all'infrastruttura tecnologica e all'integrazione di sistemi e tecnologie, 
mettendo a disposizione risorse, esperienza, entusiasmo, know-how tecnico e commerciale.

### La nostra missione

Fornire alle aziende consulenza, servizi e soluzioni integrate per la gestione dell'infrastruttura e dei contenuti informatici. 
Portare le nostre esperienze, ottenute in anni di lavoro sul campo, presso realtà differenti e complesse, al servizio dei clienti, 
per fornire non solo i prodotti migliori, ma anche per affiancare e supportare le aziende nelle loro scelte.

### I nostri clienti

Il parco clienti di CactusCorp è piuttosto eterogeneo, sia come tipologia, sia come settore merceologico.
Fra i propri clienti CactusCorp annovera numerose piccole e medie imprese e alcune grandi aziende dei più svariati settori merceologici, 
dall'artigianato all'industria, dal commercio ai servizi.
CactusCorp segue inoltre diversi enti pubblici, università e ordini professionali, nonché strutture sanitarie e ospedaliere, 
del pubblico servizio e private.
",
    sector: "Consulenza",
    no_employees: "10-20",
    fbpage: "https://www.facebook.com/leadingbyexample/",
    links: "https://www.cactuscorp.com",
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
