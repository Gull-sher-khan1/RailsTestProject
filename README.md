# RailsTestProject

Ruby Version:
* Version : 2.7

System Dependencies
* Ruby 2.7
* Rails 5.2
* Postgresql 14

Gems
* font-awesome-rails
* ransack

* Configuration
  1. get code from git before starting.
  2. system dependency must be installed like ruby, rails and postgres of above mentioned versions.
  3. the user profile in postgres must be created first before starting rails server.
  4. user profile and password must be set in credentials.
  5. mailer sender email and password (for customization) must be set in credentials before starting rails server.
  6. cloudinary credentials (for customization) must be set in credentials.

* Database creation
  1. for database creation first run command rake db:setup which will create and setup database all together.
  2. you might need to create a database of the test project application inside postgresql before starting server

* Database initialization
  1. run all the migrations inside the rails application using command rake db:migrate which will run migration in order
  2. for seed if present to update db, you must run command rake db:seed to initialize it

* How to run the test suite

* Services
  1. Cloudinary Service object (for basic cloudinary API operations) contains Upload (for individual file upload), batch_upload (for multiple file uplaods), destroy (for individualy destroying file), batch_destroy (for destroying multiple files)

* Deployment instructions
  1. for deployment on heroku enable automatic deploys for git to make deployment auto and easier on pushing in git.
  2. on deployment got to console and run commands given below in order.
  3. rake db:setup, rake db:migrate, rake db:seed
  4. in order to run on console and test models use rails c

* ...
