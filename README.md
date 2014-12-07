Bitium Assignment
=====

[![Build Status](https://semaphoreapp.com/api/v1/projects/b5d3130e-3275-4908-8022-03ae0b4f7a99/304663/shields_badge.svg)](https://semaphoreapp.com/josuelima/bitium_cache)
[![Code Climate](https://codeclimate.com/github/josuelima/bitium_cache/badges/gpa.svg)](https://codeclimate.com/github/josuelima/bitium_cache)
[![Test Coverage](https://codeclimate.com/github/josuelima/bitium_cache/badges/coverage.svg)](https://codeclimate.com/github/josuelima/bitium_cache)

This is an assignment made to Bitium.com

The objective is to present the user with the most relevant applications by determining which ones they are already using.

To do this, a set of applications, and assets used by them, are previously defined at the database, and this tool checks if the user has recently used any of them. It uses a technique described at http://lcamtuf.coredump.cx/cachetime/ , which basically consists in loading the application asset in an iframe and checking the loading speed. If the resource loads quickly we can assume it was cached.

## Install and run
- Clone this repo
- run: `bundle install` to install the gems
- run: `rake db:migrate` to create the database
- run: `rake db:seed` to seed the database with some apps and user
- run: `rails s`

If you don't want to create a new user just use the one created at `seeds.rb`