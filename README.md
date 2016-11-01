# Isamuni 
[![Build Status](https://travis-ci.org/sic2/isamuni.svg?branch=master)](https://travis-ci.org/sic2/isamuni)

The word **isamuni** comes from the Sicilian dialect and means: **let's stand up**.

Isamuni is an aggregator of information for Facebook groups. The goal is to facilitate the communication and integration across the following parties:
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
export ISAMUNI_ADMINS=<list of user uids divided by space ' '> # This is required only if you want to be an admin
```

#### Test end-point
If you want to run the app locally, you need to redirect the requests to the `squirrels.vii.ovh` server to your machine (localhost).

Change the file `/etc/hosts` (you must be root) to include the following line:
```
127.0.0.1	squirrels.vii.ovh
```

### Run the Rails App

**Requirements**

1. Install Ruby (2.2.2+)
2. Install Rails (5.0+)

**Setup**
```
$ cd isamuni/webapp/
$ rails db::create # if necessary
$ rails db::migrate
```

To populate the database run:
```
$ rails db:seed
```
This will populate your database with some default entries. Otherwise use the crawler (see below).

**Running the App**
```
$ bundle install
$ rails server
Connect to squirrels.vii.ovh:3000  
```

**Running the Crawler**

Make sure the database was initialized, then

```
$ rails crawl
```

To execute crawling periodically you can either add that command to a cron job (remember setting PATH and ENV) or use

```
$ clockwork crawler_clock.rb
```

### Docker

#### Installation

**Linux**

- Install Docker for Linux ([see here](https://docs.docker.com/engine/installation/))

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
ISAMUNI_ADMINS=<list of user uids divided by comma ','>
```

Then build and run the containers:
```
$ docker-compose build
$ docker-compose up
```

You can also run a single components (eg. the crawler)
```
$ docker-compose up crawler
```
