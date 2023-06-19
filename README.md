# My Top Favorite Web Application - Ruby on Rails Back End

## Table of Content

1. [Application Overview](#application-overview)
2. [Back End Description](#back-end-description)
3. [Technologies](#technologies)
4. [Installation](#installation)
5. [Getting Started](#getting-started)

---

## **Application Overview** <a name="application-overview"></a>

My Top Favorite is a social media platform where registered users can create, edit and share lists containing a rank of their favorite things of a certain theme. Along with each list item, the user has the option to attach a personalized text talking about the chosen item. Users can also follow other users to keep up with their listings.

The platform is integrated with external APIs, therefore, when creating a list, the user can search for items belonging to that theme in reliable sources. As an example, a user creating a list of his favorite action movies will be able to search for them in the collection of the Tmdb platform.

Currently the platform supports lists with themes related to movies, series and public personalities.The theme possibilities are endless and new themes will be supported soon!

## **Back End Description** <a name="back-end-description"></a>

The platform implementation is split into two repositories. This repository contains the back end (API) and [this repository](https://github.com/AmandaFI/MyTopFavorite-Web-Application-Frontend) contains the front end implementation using React.

The API was implemented using the Ruby programming language and the Ruby on Rails framework following the REST architectural design pattern and the Model–view–controller (MVC) software design pattern. The chosen SQL database was SQlite and the Object Relational Mapping (ORM) system used was the Active Record.

For testing and validation of the API endpoints, the Visual Code extension Thunder Client was used.

As mentioned in the [overview](#Overview) section, only registered users can interact with the platform features, therefore the authentication process was implemented using sessions and cookies.

Among the many features provided by this application, a logged user is able to access certain pages to see and interact ('Like') with lists shared by the users he follows. From the API point of view, lists displayed on this areas are fetched using the offset pagination type.

While running both, back end and front end locally, the rack-cors gem was used to avoid Cross-Origin Resource Sharing (CORS) problems.

## **Technologies** <a name="technologies"></a>

- [Ruby](https://www.ruby-lang.org/pt/) version 3.1.4
- [Ruby on Rails](https://rubyonrails.org/) version 7.0.5
- [rbenv](https://github.com/rbenv/rbenv) version 1.2.0
- Rails gem [sqlite3](https://rubygems.org/gems/sqlite3/versions/1.3.11?locale=pt-BR) version 1.4
- [Thunder Client](https://www.thunderclient.com/)
- [rack-cors gem](https://github.com/cyu/rack-cors) version 2.0
- [Faker gem](https://github.com/faker-ruby/faker) version 3.2

## **Installation** <a name="installation"></a>

To run this project locally the following prerequisites are necessary:

- Ruby installed
- Ruby on Rails installed

If your system does not meet the mentioned prerequisites the following instructions may help:

### **Linux systems**

1 - Install rbenv by cloning its repository and configuring the shell system. Run the following sequence of commands on a bash terminal.

```bash
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

For Ubuntu systems:

```bash
$ echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
```

For other Linux Distros:

```bash
$ echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bash_profile
```

2 - Restart the shell and install the rbenv plugin ruby-build:

```bash
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
```

3 - Install the Ruby version used on this project and the Bundler gem:

```bash
$ rbenv install -v 3.1.4
$ rbenv global 3.1.4
$ gem install bundler
```

4 - Install rails:

```bash
$ gem install rails
```

### **macOS systems**

1 - Install rbenv:

```bash
$ brew install rbenv ruby-build
```

2 - Follow steps 3 and 4 from the Linux installation.

### **Windows systems**

1 - Donwload the corresponding Ruby version installer from the [official site](https://rubyinstaller.org/).

2 - Run on terminal:

```bash
$ gem install rails --version “7.0.5”
```

## **Getting Started** <a name="getting-started"></a>

If your system meets the mentioned prerequisites just clone this repository and run the following initialization commands:

```bash
$ git clone https://github.com/AmandaFI/MyTopFavorite-Web-Application-Backend.git
$ cd MyTopFavorite-Web-Application-Backend
```

Install the project dependencies and setup the database.

```bash
$ bundle install
$ rails db:setup
$ rails db:migrate
```

Observation: the file db/seeds.rb contains a mock data set, built with the Faker gem, that can be used to populate the database using the command:

```bash
$ rails db:seed
```

Finally run the API server:

```bash
$ rails s
```

By default, the Rails server runs on http://127.0.0.1:3000, however this can be changed if necessary.
