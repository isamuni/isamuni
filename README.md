# Isamuni

[**Telegram Group**](https://telegram.me/joinchat/Bk1QGAlK-ZUJ0ZidWo4CYA)

[**isamuni.it**](https://www.isamuni.it)

[**beta version**](https://beta.isamuni.it)

## Index

* [Project description](#project-description)
* [How to deploy](#how-to-deploy)
 * [Environment Configuration](#environment-configuration)
 * [Running the App](#running-the-app)
 * [More Configuration](#more-configuration)
 * [Via Docker](#docker)
* [FAQ](#faq)
* [Contributors](#contributors)


## Project description

**isamuni** is a lazy social network for small communities. Forget about chats and posting your mad ideas. There are already thousands of other solutions for that. **isamuni**, instead, aggregates data from multiple selected social networks (e.g. FB, Twitter, NodeBB forums) for a better understanding of what is happening with a commmunity (e.g. tech community of a particular region, football clubs of a certain league, book readers across the country). Moreover, **isamuni** allows individuals and groups of people to create neat and beautiful static pages to tell others how great they are.

Isamuni relies on its sister project [Favara](https://github.com/sic2/favara) to crawl events from various sources and get them into its database.

### Why did you create isamuni?

The basic idea of isamuni was conceived in 2013 in Sicily, Italy. But it was not until May 2016 that this idea became clear and we started to make isamuni.

Over the last few years, we have noticed that many tech communities and startups/companies are constantly being created or already exist, but not many people really know about them. This meant: many experts, professionals, students and tech lovers. Put it simply: a lot of value and opportunities. There is, however, a significant fragmentation across the different components of the general tech Sicilian community.

Therefore, we created **isamuni** to facilitate the communication and integration between individuals and groups of people within a larger community.


Find an example of isamuni at [isamuni.it](http://www.isamuni.it). In this case, the Sicilian tech community (Sicily, Italy) is represented by tech professionals, students and hobbyist as well as nonprofit communities and companies/startups of the tech sector.


### Main features

So, what does isamuni really do? isamuni aggregates:
- users
- communities and companies
- social activity from different social networks
- events

Data aggregated under isamuni is **searchable, easy to explore and open to other sources/applications, via a RESTful API**. See the project [unni](https://github.com/sic2/unni) as an example.


### Meaning of isamuni

Now, you may wonder: why the word **isamuni**? The word **isamuni** comes from the Sicilian dialect and means: **let's stand up**. We think that isamuni can help communities to grow stronger together, that isamuni can help communities to stand up.


### More
Checkout our [Showcase](https://github.com/sic2/isamuni/wiki/Showcase)

More info (plus a roadmap) in the [wiki](https://github.com/sic2/isamuni/wiki)

## How to deploy

### Environment Configuration

#### Facebook APP ID
To allow the login to work using Facebook, you will have to create a Facebook app (if you do not have one already). [Here](https://developers.facebook.com/docs/apps/register) is a guide from Facebook on how to create one.

In your bash *.profile* file, add:

```bash
export ISAMUNI_APP_ID=appid
export ISAMUNI_APP_SECRET=secret
export ISAMUNI_ADMINS=<list of facebook user uids divided by space ' '> # This is required only if you want to be an admin
export SMTP_PORT="2525"
export SMTP_HOST="smtp.mailgun.org"
export SMTP_USERNAME="USERNAME HERE"
export SMTP_PASSWORD="PASSWORD HERE"
export SMTP_DOMAIN="DOMAN HERE"
export ISAMUNI_ADMINS_MAILS="YOUR_MAIL_HERE"
```

(or ask a developer for the already compiled lines)

#### Setup rails

**Get rails on your system**

you'll need recent versions of ruby (2.3+), nodejs and rubygem. You can find some good installation guides [here](https://gorails.com/setup/ubuntu/16.04)

```bash
# Install yarn (for rails webpacker). See https://yarnpkg.com/lang/en/docs/install/

# Install isamuni's dependences
# (you'll need to repeat this step every time some dependences are updated)
$ cd isamuni/webapp
$ bundler
$ yarn
```


### Database setup

We are using postgres on development and production mode.

#### With docker

You can use docker to run the database, while starting rails normally. To run the database with docker, run `docker-compose up --build devdb`, and stop it with `docker-compose down devdb`. This option doesn't require you to install postgres. You'll only need to do `rails db:create` on the first usage. That's it

#### Without docker

First, make sure that you have postgres installed on your machine.
Then create a user and a database for isamuni:

```bash
$ sudo -u <YOUR USERNAME> psql postgres

# Entering psql interactive mode and create a user for isamuni
# we'll then let the app create the databases with `rails db:create`

$ CREATE USER isamuni SUPERUSER;
$ CREATE DATABASE isamuni_dev WITH OWNER isamuni;
```

Then ask webapp to create the database and bring it to the last version of the schema

```bash
$ cd isamuni/webapp/
$ rails db:create # if necessary
$ rails db:migrate
```

#### Test data

To populate the database with some default/test entries run:

```bash
$ rails db:fixtures:load
```

Use the crawler to get posts and events (see below).

### Running the App

```bash
$ bundle install # Execute this only when dependencies change
$ yarn
$ rails server webrick
```

### Using Favara to get the latest posts

Make sure the database is initialized, and already migrated to the last version.

Then clone [favara](https://github.com/sic2/favara) in a different folder, point it to the same database Isamuni uses, and run it.
Refer to favara's readme for further details.


### More Configuration

#### Editing webpack-managed assets

A part of the javascript assets is handled by webpacker
Webpack is configured like this:

* The dependences are listed in `package.json`, and are installed through `yarn`
* The source files are in the `/app/javascript/packs` folder.
* The Webpack configuration is in `/config/webpack`
* The entrypoint is in `/app/javascript/packs/application.js`
* You don't need to do anything special to start the server

#### Configuring your editor

You may want to install the following packages:

Atom (Best):
```
atom-beautify (please set a tab-width of 2 for ruby)
base16-syntax
file-icons
language-vue
linter
linter-eslint
linter-rubocop
git-time-machine
```

SublimeText:
```
"BeautifyRuby",
"HTML-CSS-JS Prettify",
"JsFormat",
"Package Control",
"SublimeLinter",
"SublimeLinter-contrib-eslint",
"Vue Syntax Highlight"
```

### Docker

#### Installation

**Linux**

- Install Docker and docker-compose for Linux ([see here](https://docs.docker.com/engine/installation/))

**Mac**

- Install Virtual Box
- Install Docker for Mac
- Run `docker run hello-world` to check your installation
 - If a timeout error is given, change your DNS to Google's DNS


#### Building the Image and Running the App

- Create a `.env` file containing the following:

```
ISAMUNI_APP_ID=appid
ISAMUNI_APP_SECRET=secret
ISAMUNI_ADMINS=<list of user uids divided by space ' '>
ISAMUNI_ADMINS_MAILS=<list of user uids divided by space ' '>
ISAMUNI_DATABASE_HOST=devdb
SMTP_PORT=2525
SMTP_HOST=smtp.mailgun.org
SMTP_USERNAME=MAILGUN_SMTP_USERNAME_HERE
SMTP_PASSWORD=MAILGUN_SMTP_PASSWORD_HERE
SMTP_DOMAIN=MAILGUN_SMTP_DOMAIN_HERE
```

Then build and run the containers:
```
$ docker-compose build
$ docker-compose up

# When you finish testing
$ docker-compose down
```

You can also run a single components (eg. the database)
```
$ docker-compose up devdb
```

## FAQ

- Does isamuni work only with FB?
    + No. We are currently in the process of moving out the crawler component of isamuni into its own project. The crawler will support multiple sources (facebook, twitter, nodebb, etc)
- Is isamuni only about Sicily and technology?
    + No. The instance at isamuni.it is for the specific use case of the tech community in Sicily. However, we are working on generalising the isamuni framework to support other regions and other sectors too (e.g. gamers, book lovers, football fans, etc)
- I already use FB and Twitter. How is isamuni better?
    + Isamuni is not attempting to overtake the giants of the web. Isamuni, instead, attempts to solve the fragmentation issue that comes with using multiple social networks as well as the despertion of information within a given social network
- I already use Linkedin. I do not want to join isamuni
    + Linkedin is a world database for professionals. Isamuni's goal is to aggregate local professionals, students, and hobbyists.
    Also, you do not have to join isamuni if you do not wish to create your own profile page or company/community page
- I like this project and would love to run an instance myself
    + Please do so. That would be really great. We ask you, however, to respect the license of the project. Also, let us know about your isamuni instance and we will list it here on this README file
- I like isamuni and I would love to contribute
    + Join our [Telegram group](https://telegram.me/joinchat/Bk1QGAlK-ZUJ0ZidWo4CYA)(very-responsive) or email us (programmatori.a.catania+isamuni@gmail.com)

## Contributors

* [@sic2](https://github.com/sic2) - co-founder
* [@vigliag](https://github.com/vigliag) - co-founder
* [@giupardeb](https://github.com/giupardeb)
* [@aegroto](https://github.com/aegroto)
