# Isamuni 
[![Build Status](https://travis-ci.org/sic2/isamuni.svg?branch=master)](https://travis-ci.org/sic2/isamuni)

The word **isamuni** comes from the Sicilian dialect and means: **let's stand up**.

Isamuni is an aggregator of information about local communities. The goal is to facilitate the communication and integration across the following parties:
* Type I : Companies, corporations, startups, and spin-offs in the tech world
* Type II : Incubators, accellerators, universities, and communities
* Type III : Students, professionals, and enthusiasts

## Index

* [Configuring and Running the App](#configuring-and-running-the-app)
* [How to deploy](#how-to-deploy)
 * [Via Docker](#docker)

Checkout our [Showcase](https://github.com/sic2/isamuni/wiki/Showcase)

More info and roadmap in the [wiki](https://github.com/sic2/isamuni/wiki)

### How to deploy

#### Configure the environment

#### Facebook APP ID
To allow the login to work using Facebook, you will have to create a Facebook app (if you do not have one already). [Here](https://developers.facebook.com/docs/apps/register) is a guide from Facebook on how to create one.

In your bash *.profile* file, add:

```
export ISAMUNI_APP_ID=appid
export ISAMUNI_APP_SECRET=secret
export ISAMUNI_ADMINS=<list of facebook user uids divided by space ' '> # This is required only if you want to be an admin
```

To make the facebook login work, your browser needs to access the website with the same domain you registered for your application in the developer console. You can either add "localhost" as domain in the console, or add the host to your hostfile. On linux/macOS you'd add to the file `/etc/hosts` to include the following line (we're using `squirrels.vii.ovh` as example).

```
127.0.0.1	squirrels.vii.ovh
```

### Setup rails

**Get rails on your system**

you'll need recent versions of ruby (2.3+), nodejs and rubygem. You can find some good installation guides [here](https://gorails.com/setup/ubuntu/16.04)

```bash
# Install some required tools
$ (sudo) gem install foreman
$ (sudo) npm install -g webpack

# Install isamuni's dependences
# (you'll need to repeat this step every time some dependences are updated)
$ cd isamuni/webapp
$ bundle install
$ npm install
```

**Database setup**

We are currently using sqlite for development and postgres in production.
To setup the development database, these steps will suffice

```
$ cd isamuni/webapp/
$ rails db::create # if necessary
$ rails db::migrate
```

To populate the database with some default/test entries run:
```
$ rails db:seed
```

Use the crawler to get posts and events (see below).

**Running the App**
```
$ bundle install
$ rails server

Point your browser to squirrels.vii.ovh:3000  
```

**Running the Crawler**

Make sure the database was initialized, then run the `crawl` rake task with

```
$ rails crawl
```

To execute crawling periodically you can either add that command to a cron job (remember setting PATH and ENV) or launch the crawler_clock script with clockwork

```
$ clockwork crawler_clock.rb
```

**Editing webpack-managed assets**

A part of the javascript assets is handled by webpack, which allows us to take advantage of modern javascript frameworks, obtain better modularity, hot reloading, and make the front-end more independent from the backend.

Webpack is configured like this:

* The dependences are listed in `package.json`, and are installed through `npm install`
* The source files are in the `/webpack` folder.
* The Webpack configuration is in `webpack.config.js`
* The entrypoint is in `/webpack/App.js`, which is compiled into `/app/assets/javascripts/App.js`. This file needs to explicitly export anything you want to be able to access from the other `<script>` tags in the page. The exports will be available as `App`
* `/app/assets/javascripts/App.js` is included in the sprockets bundle like any other library, that will handle fingerprinting and caching for us
* `npm run build` compiles and minifies the webpack-managed assets
* `npm run watch` recompiles the files on save
* `npm run dev` starts a development server that will only serve `App.js` and proxies all the other requests to `squirrels.vii.ovh:3000`. It will provide hot reloading, but it will not touch the `App.js` file on disk. Please use `build` or `watch` to rebuild `App.js` when you are done testing.
* a procfile is provided to start both `rails server` and `npm run watch`. You can run it with `foreman start`.

#### Configuring your editor

You may want to install the following packages:

Atom (Best):
```
atom-beautify
base16-syntax
file-icons
language-vue
linter
linter-eslint
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
 - If a timout error is given, change your DNS to Google's DNS


#### Building the Image and Running the App

- Create a `.env` file containing the following:

```
ISAMUNI_APP_ID=appid
ISAMUNI_APP_SECRET=secret
ISAMUNI_ADMINS=<list of user uids divided by space ' '>
```

Then build and run the containers:
```
$ docker-compose build
$ docker-compose up

# When you finish testing
$ docker-compose down
```

You can also run a single components (eg. the crawler)
```
$ docker-compose up crawler
```
