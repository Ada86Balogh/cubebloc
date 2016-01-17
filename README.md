# Cubebloc

Cubebloc is a work ready Vagrant box that provides you a development environment without requiring you to install any server software on your local machine.

Cubebloc runs on any Windows, Mac, or Linux system, and includes the latest technologies so all you have to do is fire up and start your fresh new projects.

Box on Atlas:

  * [adamoa/cubebloc](https://atlas.hashicorp.com/adamoa/boxes/cubebloc)

Current stable version of the box:

  * v1.0.4

Current Vagrant Providers:
  * Virtualbox ^5.0.0 (Guest Additions Version: 5.0.12)

## Table of contents

  * [Included Software](#included-software)
  * [Installation](#installation)
  * [First Steps](#first-steps)
    * [Connecting Via SSH](#connecting-via-ssh)
    * [Adding New Site](#adding-new-site)
    * [Removing Site](#removing-site)
    * [MySQL](#mysql)
    * [Redis](#redis)
      * [Redis Password](#redis-password)
    * [Host file](#host-file)
  * [Windows Users](#windows-users)
  * [Additional Setup](#additional-setup)
    * [Shared Folder](#shared-folder)
    * [IP Address](#ip-address)
    * [Resources](#resources)
    * [Forwarded Ports](#forwarded-ports)
  * [Contact](#contact)

## Included Software

  * Ubuntu 14.04
  * Apache2
  * PHP 7.0
  * MySQL 5.7
  * Redis
  * Composer (with Laravel installer)
  * Node 5.4.1 (with nvm, npm and Gulp)

## Installation

```bash
$ vagrant box add adamoa/cubebloc
$ git clone https://github.com/adamoa/cubebloc.git cubebloc
$ cd cubebloc
$ vagrant up
```

## First Steps

#### Connecting Via SSH

The simpliest way to connect to your virtual machine is to jump into the vagrant folder and use the `vagrant ssh` command.

```bash
$ cd /path/to/vagrant/folder
$ vagrant ssh
```

However after the 100th times it could be annoying so we can setup some alias for it to reach anywhere from our system.

#### Adding New Site

Cubebloc provides you a simple script what you can use to add new sites to your web server easily. All you have to do is to give it the proper arguments.

The first is the "domain" and the second is the path of the directory. **Important** to remember the whole path will /var/www/cubebloc but you only have to add the rest of it.

```bash
$ vagrant ssh
$ a2newsite.sh <domain> <path>
```

###### Example

```bash
$ vagrant ssh
$ a2newsite.sh example.cube example/public
```

So you can reach your site on example.cube and the docroot will be /var/www/cubebloc/example/public

#### Removing Site

You got another script for removing site from your webserver. But now you only have to type the domain of it.

```bash
$ vagrant ssh
$ a2removesite.sh <domain>
```

###### Example

```bash
$ vagrant ssh
$ a2removesite.sh example.cube
```

#### MySQL

The environment shipped with the latest version of the MySQL, with the MySQL 5.7 (5.7.10 to be correct)

There are two users:

| User | Password |
| ---- | -------- |
| root | secret|
| laravel | secret |

And two databases set:

| Database | Character | Collate |
| -------- | --------- | ------- |
| laravel | utf8 | utf8_unicode_ci |
| testing | utf8 | utf8_unicode_ci |

#### Redis

Redis is binded to the 127.0.0.1 address and protected by password. If you would like to change it edit the config file.

```bash
$ sudo vi /etc/redis/redis.conf

...
 32 # Examples:
 33 #
 34 # bind 192.168.1.100 10.0.0.1
 35 bind 127.0.0.1
...
306 # Warning: since Redis is pretty fast an outside user can try up to
307 # 150k passwords per second against a good box. This means that you should
308 # use a very strong password otherwise it will be very easy to break.
309 #
310 requirepass secret
311
...

$ sudo service redis-server restart
```

###### Redis password

The password is: **secret**

#### Host file

And do not forget to add your "domain" to your host file:

  * Linux: /etc/hosts
  * Windows: /Windows/System32/etc/drivers/host

```bash
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1 localhost
192.168.33.10 <domain>
```

Now if you check your `<domain>` in the browser you'll see your site.

## Windows Users

Those who run their Vagrants on Windows could have some problems with the installation of the npm packages. There is an advice that we should install them with *--no-bin-links* flag however it is not the best way plus most of the times it is still not working. With Cubebloc it is fixed all you have to do is run your terminal with adminstrator or add your user to the Local security settings.

## Laravel

Because of everything is prepared for Laravel all you have to do is to login to you vagrant and create a new project with composer.

```bash
$ vagrant ssh
$ cd /var/www/cubebloc
$ composer create-project laravel/laravel <project-name>
$ a2newsite.sh <project-name>.cube <project-name>/public
$ cd <project-name>
```

And do not forget to add your "domain" to your host file:

  * Linux: /etc/hosts
  * Windows: /Windows/System32/etc/drivers/host

```bash
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1 localhost
192.168.33.10 <project-name>.cube
```

Now if you check `<project-name>.cube` in the browser you will see a fresh installation of Laravel 5. And because of the preparation even if you are a windows user you can run npm install without any problem and use laravel-elixir with all it's feature. Cool.

## Additional Setup

However Cubebloc provides basically everything what we need out of the box but there could some cases when we need to configure it a little bit.

Just do not forget to run Vagrant provision or restart it after the changes.

```bash
$ vagrant provision
```

#### Shared Folder

At default the shared folder will be the projects directory and it will be synced to /var/www/cubebloc. But if you don't like it you can change it in the Vagrantfile:

```ruby
13 config.vm.synced_folder "./projects", "/var/www/cubebloc"
```

All you have to do is to change the values in line 13. First parameter is the path on the host and the second is the path on the virtual machine.

#### IP Address

We can reach our virtual machine on the 192.168.33.10 address. However if you would like to change it just edit the 11th line of the Vagrantfile:

```ruby
11 config.vm.network "private_network", ip: "192.168.33.10"
```

#### Resources

Cubebloc uses 2 cores of your CPUs and 2 GB memory. If it is too much or you would like to give it more just edit the proper lines in the Vagrantfile:

```ruby
20 vb.cpus = "2"
21 vb.memory = "2048"
```

*Warning! Less resources could change your virtual machine performance drastically.*

#### Forwarded Ports

Basically two ports are forwaded from your host to your virtual machine but if you wanna modify them or add more you can do it in the Vagrantfile:

```ruby
8 config.vm.network "forwarded_port", guest: 80, host: 8080
9 config.vm.network "forwarded_port", guest: 3306, host: 33060
```

## Contact

If you got any question or problem do not hesitate to contact me. I'll do my best to answer or help to you.

You can open an issue here or write an email. Happy coding on cubebloc!
