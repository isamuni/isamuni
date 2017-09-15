# Isamuni

[**Telegram Group**](https://telegram.me/joinchat/Bk1QGAlK-ZUJ0ZidWo4CYA)
[**isamuni.it**](https://www.isamuni.it)

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

## Getting started with development

### Environment Configuration

Some of the features of isamuni are disabled unless some environment variables as set.
You can easily set them putting a `.env` file in the `webapp` directory with these contents.

Better yet, ask one of the developers and we'll share our ready-to-use env file.

```bash
#facebook api configuration (see https://developers.facebook.com/docs/apps/register )
export ISAMUNI_APP_ID=appid
export ISAMUNI_APP_SECRET=secret

#email configuration
export SMTP_PORT="2525"
export SMTP_HOST="smtp.mailgun.org"
export SMTP_USERNAME="USERNAME HERE"
export SMTP_PASSWORD="PASSWORD HERE"
export SMTP_DOMAIN="DOMAN HERE"
```

### Development environment

You'll need recent versions of:

- git
- ruby (2.3+), bundler and postgres (follow the guide [here](https://gorails.com/setup/ubuntu/16.04))
- nodejs (8+) (see [here](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions]))
- yarn (see [here](https://yarnpkg.com/lang/en/docs/install/))

Then from the webapp folder

```bash
$ cd isamuni/webapp
$ bundler #re-run every time ruby dependencies change
$ yarn #re-run every time front-end dependencies change
```

In alternative you can install docker, docker-compose, and then run the commands you'll run in the rest of the readme with `docker-compose run isamuni <command>`. You'll need to run `docker-compose build` when dependencies change, instead of `bundler`.  

You can also opt to have the ruby environment installed, but run postgres from docker. You can start postgres from docker as `docker-compose up -d devdb`.

### Database Setup

#### With Docker

You can use docker to run the database, while starting rails normally. To run the database with docker, run `docker-compose up --build devdb`, and stop it with `docker-compose down devdb`. This option doesn't require you to install postgres. You'll only need to do `rails db:setup` on the first usage. That's it

#### Without Docker

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
$ rails db:setup
$ rails db:migrate
```

#### Test data

Ask a developer for a dump of the database!

### Running the App

```bash
# when dependencies change
$ bundle install
$ yarn

# start the server!
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
