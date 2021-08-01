# Movie API - README

## Ruby version
* 3.0.0

## Notes and assumptions
* This project has multi-line commit message mostly with the following format: "Module: Brief description. \n WHAT: Details description. \n WHY: Reason for commit."
* This project pre-populates limited omdb movie ids in the database and fetches up to date details for these movies. Movie creation endpoint is not exposed.
* This project assumes that each movie will have shows, and each show will have a show_time (datetime). When we fetch shows for a movie at `/movies/:movie_id/shows` url, only the upcoming shows are fetched. This response is part for both, the movie serialiser and the show serialise.
* This project assumes two user roles, admin and customer. Only admin users are allowed to update moview shows and price.
* This project authenticates users via JWT tokens.
* This project exposes a public endpoint for the Swagger JSON document at localhost:3000/apidocs and assumes that this will be used with an external swagger UI engine. Response from `/apidocs` can also be copied to https://editor.swagger.io/ to see the documentation.
* This project only fetches new details from the omdb endpoint if the `last-modified` timestamp on the remote server has changed since the last fetch. Otherwise, the details are read from local storage.
* This project uses PostgreSQL database to persist data.
* This project caches movie details to Redis store. If the details are not available in the store, they are fetched from PostgreSQL and written to Redis. The cache is busted if the movie details are updated in the database.
* While the OMDB API is quick enough, the reason the API and Store caching is explored here is to keep the number of API calls to a minimum. For that, I've done multiple things: Used the `If-Modified-Since` header (I'm not though sure if OMDB counts `304` responses towards the daily limit or not). Cached database reponses to redis until a `200` response updates the data in the DB. Use a stub in the integration and unit tests to avoid calls to the actual OMDB API. (I've copied a dummy response to the spec helper.)
* This project uses the Blueprinter gem for serialisation.
* The environments in the project are configured mainly for localhost. Some initialisers would need to be updated before running in production.

## Configuration (Tested on mac OSX)

* Install redis
  * https://gist.github.com/tomysmile/1b8a321e7c58499ef9f9441b2faa0aa8

* Start redis for caching:
  * `redis-server`

* Calls to cache server can be monitored via:
  * `redis-cli monitor`

* Clone repository and step into:
  ```
  git clone git@github.com:jawad-shuja/omdb_api.git
  cd ./omdb_api
  ```

* Install dependencies:
  `bundle install`

* Set up environment variables
  * Copy `.env.template` in the root of the project to `.env` in the same directory. Update the following environment variable before running the project:
    * `RAILS_MASTER_KEY` (For this test project, you may use `40eef142066a6148a18265e335080435` in order to work with the committed credentials. This is only shared because this is a test project without any sensitive data.)
    * `REDIS_URL` (Use your local redis url like redis://localhost:6379/0/cache)
    * `OMDB_API_KEY` (Use your OMDB API key)

* Set up credentials
  * If the above master key is not used, the credentials file can be deleted and created again using:
    * `rm config/credentials.yml.enc`
    * `EDITOR=vim rails credentials:edit`
      * You may use your own choice of editor. This command will create a new `config/master.key` file. Please copy it's contents to the RAILS_MASTER_KEY in the `.env` file and feel free to remove the `config/master.key` file.
      * You will need to add the following secret keys to the credentials file. You can use `rake secret` to generate new values for both of these:
        * `secret_key_base`
        * `devise_secret_key`

* Setup database:

  * Install postgresql:
    * https://www.sqlshack.com/setting-up-a-postgresql-database-on-mac/

  * Create db and run migrations:
    ```
    rails db:create
    rails db:migrate
    ```

* Seed database
  * `rails db:seed`
  * This seeds the database with a default catalogue of movies with their OMDB ids.

* Start server
  * `rails s`

## Test suite
  * Run the test suite
    * `bundle exec rspec`
  * Contains request tests for
    * Movies controller actions
    * Reviews controller actions
    * Shows controller actions
  * Contains unit tests for
    * Movie model validations
    * Movie fetch logic (With omdb webmock stub)
    * Review model validations
  * Contains Fatorybot + Faker fixtures for
    * Users
    * Movies
    * Shows
    * Reviews

## Suggestions & improvements
  * Refresh token logic can be added via secure, httponly cokies.
  * CORS config would have to be updated for production instances.
  * Model validations can be extended.
  * Unit tests can have more extensive coverage.
  * More thought can go int Redis cache expirations.
  * A Swagger UI engine can be bundled with the app. I did not spend much time on this because I was working with an api only Rails app. Please use https://editor.swagger.io/ to explore the Swagger json generated at the /apidocs url.
  * The JWT revocation strategy can be thought about more as well. I added some logic while following the library instructions but the need for this varies from use case to use case. Most apps I've worked on before tend to keep the user logged in via a refresh token.
  * Rubocop can be further configure for better suggestions.
  * If the API is extended to expose movie creation endpoint, we can add validation to avoid duplication of movies.
  * There's a default order scope on the reviews model. Additional scopes can be added if needed.
