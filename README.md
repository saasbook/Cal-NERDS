# Cal-NERDS

[![Maintainability](https://api.codeclimate.com/v1/badges/cc2cc04e461db816fbe3/maintainability)](https://codeclimate.com/github/cs169-group7/Cal-NERDS/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/cc2cc04e461db816fbe3/test_coverage)](https://codeclimate.com/github/cs169-group7/Cal-NERDS/test_coverage)
[![Build Status](https://travis-ci.org/cs169-group7/Cal-NERDS.svg?branch=master)](https://travis-ci.org/cs169-group7/Cal-NERDS)

[https://damp-brushlands-79654.herokuapp.com/](https://damp-brushlands-79654.herokuapp.com/)

This app can be deployed to Heroku. Some notes:

* It uses Google OAuth and so requires you to use figaro to set the `GOOGLE_KEY` and `GOOGLE_SECRET`.
* ActionMailer needs an email address to send emails from. The address and password should also be in the figaro YAML file as `gmail_username` and `gmail_password`, respectively.
* The db should be seeded with a user whose `auth` and `admin` attributes are set to `true` so that upon deployment there is already someone who can log in and make other uses auths or admins.
* To create an auth user, that user needs to log in with Google and then an admin will be able to authorize them from the `/users` page.
