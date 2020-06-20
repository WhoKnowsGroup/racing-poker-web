# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact


###Set up####

This repo should be compiled as 'WAR" file
In regards to dependencies, there is no dependency package manager. I added all required jars in lib folder.
If you need jars for dependencies, I can provide you the list of jars used in WaR.

This repo requires User-management.ejb to be added as jar.
This repo always to connects to streamline sockets for user game connections. The ports used are 1060, 1070.

Game runs in the Streamline Sockets, not in the WAR file.
The game logic resides in streamline sockets.

We used web sockets to run the game.

In regards to DB, we used lightCouchdb. It's a noSql database. The database is on 72 server.