# Isamuni

The word **isamuni** comes from the Sicilian dialect and means: **let's stand up**.

Isamuni is an aggregator of information for Facebook groups. The goal is to facilitate the communication and integration across the following parties:
* Type I : Companies, corporations, startups, and spin-offs in the tech world
* Type II : Incubators, accellerators, universities, and communities
* Type III : Students, professionals, and enthusiasts

## Configuring and Running the App

You can skip this section if you do not need to deploy **isamuni** in a cloud service.

### Connecting to the droplet

The first step to connect to the droplet is to generate a valid pair of ssh keys.

For Mac/Linux
```
$ ssh-keygen -f ~/.ssh/YOURID -C "YOURID" # YOURID is just a readable string (e.g. pacid)

Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/MACHINENAME/.ssh/YOURID.
Your public key has been saved in /Users/MACHINENAME/.ssh/YOURID.pub.
The key fingerprint is:
7a:9c:b2:9c:8e:4e:f4:af:de:70:77:b9:52:fd:44:97 YOURID
The key's randomart image is:
+--[ RSA 2048]----+
|         |
|         |
|        .|
|        Eo|
|  .  S  . ..|
|  . . o . ... .|
|  . = = ..o o |
|  . o X ... . .|
|  .ooB.o ..  |
+-----------------+

```

Then add your public key to the droplet (one of the admins can do it). Do not worry, you can share your public key without having to worry that someone will steal your identity. But, **NEVER EVER** share your private key.

If you want to manage multiple keys, you can create an `SSH config file`.

```
$ touch ~/.ssh/config
$ emacs ~/.ssh/config # use any editor you like


# Manage your keys in ~/.ssh/config as below

Host workid
 HostName bitbucket.org
 IdentityFile ~/.ssh/workid

Host squirrels.vii.ovh
 HostName squirrels.vii.ovh
 IdentityFile ~/.ssh/pacid
```


Useful resource: [SSH Identified in Atlassian](https://confluence.atlassian.com/bitbucket/configure-multiple-ssh-identities-for-gitbash-mac-osx-linux-271943168.html)

### How to deploy

#### Configure the environment

#### Facebook APP ID
To allow the login to work using Facebook, you will have to create a Facebook app (if you do not have one already). [Here](https://developers.facebook.com/docs/apps/register) is a guide from Facebook on how to create one.

In your bash *.profile* file, add:

```
export ISAMUNI_APP_ID=appid
export ISAMUNI_APP_SECRET=secret
```

#### Test end-point
If you want to run the app locally, you need to redirect the requests to the `squirrels.vii.ovh` server to your machine (localhost).

```
$ sudo /etc/hosts

Add the following to the file:
127.0.0.1	squirrels.vii.ovh
```

### Run the Rails App

**Requirements**

1. Install Ruby
2. Install Rails
3. Install rake --> `gem install rake`

**Setup**
```
$ cd /isamuni/webapp/
$ rake db::create # if necessary
$ rake db::migrate
```

To populate the database run:
```
$ rake db:seed
```

**Running the App**
```
$ bundle install
$ rails server
Connect to squirrels.vii.ovh:3000  
```
