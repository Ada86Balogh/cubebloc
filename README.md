# Cubebloc

## Table of contents
  * [Introduction](#introduction)
  * [Included Software](#included-software)
  * [Installation and Configuration](#installation-and-configuration)
    * [Config Cubebloc](#config-cubebloc)
  * [First Steps](#first-steps)
    * [Connecting Via SSH](#connecting-via-ssh)
    * [MySQL](#mysql)
    * [PostgreSQL](#postgresql)
    * [MongoDB](#mongodb)
    * [Redis](#redis)
    * [Host file](#host-file)
  * [Windows Users](#windows-users)
  * [Contact](#contact)

## Introduction

Cubebloc is a work ready Vagrant box that provides you a development environment without requiring you to install any server software on your local machine.

Cubebloc runs on any Windows, Mac, or Linux system, and includes the latest technologies so all you have to do is fire up and start your fresh new projects.

Current stable version of the box:

  * **v1.2.0**

Box on Atlas:

  * [adamoa/cubebloc](https://atlas.hashicorp.com/adamoa/boxes/cubebloc)

Current Vagrant Providers:
  * Virtualbox ^5.0.0 (Guest Additions Version: 5.0.12)

> **Note:** If you are using Windows, you may need to enable hardware virtualization (VT-x). It can usually be enabled via your BIOS.

## Included Software

  * Ubuntu 14.04
  * Apache 2
  * PHP 7.0
  * Node 5.6.0
  * MySQL 5.7
  * PostgreSQL 9.5
  * SQLite 3.8.2
  * MongoDB 3.2
  * Redis
  * Composer (with globally installed Laravel installer)
  * Latest nvm and npm (with globally installed Gulp)

## Installation and Configuration

> **Note:** Before launching Cubebloc, you must install [VirtualBox 5.x](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com).

After you installed both of them you just simply fire up your Cubebloc development environment with the following steps:

```bash
$ vagrant box add adamoa/cubebloc
$ git clone https://github.com/adamoa/cubebloc.git
$ cd cubebloc
(Edig cubebloc.json for additional config. [See below](#config-cubebloc))
$ vagrant up
```

#### Config Cubebloc

However Cubebloc provides basically everything what we need out of the box but there could some cases when we need to configure it a little bit.

**Config file**
You can find a ```cubebloc.json``` file in your folder and with that you can configure your vagrant machine.

**Shared folders**

The folders property of the cubebloc.json file lists all of the folders you want. As files within these folders are changed, they will be kept in sync between your local machine and Cubebloc. You may configure as many shared folders as many needed:

```json
20   "folders": [
21     { "host": "~/cubebloc", "guest": "/var/www/cubebloc" }
22   ],
```

**Managing sites**

 The sites property allows you to easily map a "domain" to a docroot folder on your environment. An example site configuration is included in the json file.

```json
24   "sites": [
25     { "domain": "example.cube", "folder": "/var/www/cubebloc/example" }
26   ],
```

> **Note:** If you add new site do not forget to run **vagrant provision** in your terminal in you Cubebloc directory.

**Forwarded ports**

In default Cubebloc forwarded ports from host to guest so you can reach all of the goddies from your host.

| Software | Host | Guest |
| -------- |:----:|:-----:|
| Apache2 | 8000 | 80 |
| Apache2 | 4430 | 443 |
| MySQL | 33060 | 3306 |
| PostgreSQL | 54320 | 5432 |
| MongoDB | 27017 | 27017 |
| Redis | 6379 | 63790|

## First Steps

#### Connecting Via SSH

The simpliest way to connect to your virtual machine is to jump into the vagrant folder and use the `vagrant ssh` command.

```bash
$ cd /path/to/vagrant/folder
$ vagrant ssh
```

However after the 100th times it could be annoying so we can setup some alias for it to reach anywhere from our system.

#### MySQL

The environment shipped with the latest version of the MySQL, with the MySQL 5.7

There are two users:

| User | Password | Privileges | Grant |
| ---- | -------- | ---------- | ----- |
| root | secret | ALL | t |
| cubebloc | secret | ALL | f |

#### PostgreSQL

The latest version of the PostgreSQL (9.5) also included

There are two users:

| User | Password | Super User | Create DB |
| ---- | -------- | ---------- | --------- |
| postgres | secret | t | t |
| cubebloc | secret | t | f |

#### MongoDB



#### Redis

Redis is binded to the 0.0.0.0 address and it's port forwarded to 63790.
It is not protected by password. If you would like to change it edit the config file.

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
192.168.40.10 <domain>
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
192.168.33.10 <domain>
```

Now if you check `<domain>` in the browser you will see a fresh installation of Laravel 5. And because of the preparation even if you are a windows user you can run npm install without any problem and use laravel-elixir with all it's feature. Cool.

## Contact

If you got any question or problem do not hesitate to contact me. I'll do my best to answer or help to you.

You can open an issue here or write an email. Happy coding on cubebloc!
