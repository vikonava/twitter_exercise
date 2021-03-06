== README

This application was developed as an exercise using Ruby 2.3.0 with Rails 4.2.5

### Gems Used
* Testing
⋅⋅* Rspec-rails
⋅⋅* FactoryGirl
⋅⋅* Capybara
⋅⋅* Selenium-webdriver
* Development/Production
⋅⋅* Devise

### App Design Choices

#### Twitter::Api

This is a module that is located under the lib/ directory on the application. The reason of doing this was to be able to encapsulate methods that could be used in different controllers. At the same time, this was developed as a separate module to be able to give it an opportunity for that API to grow and include all of the other requests that can be made to request different user information.

#### General

This is also a module located in the config/initializers/ folder on the application. The main purpose of this module is to have some general access to settings that can be used on the application itself. The two methods that are located under this module are *settings* and *twitter_token*. The settings method, its main usage is to retrieve information, loaded only once, from the app/config/settings.json file which contains several values that are needed for the application to work and it gives flexibility for the administrator to change those values in case something changes or the requirements change. The twitter_token method is a method that calls Twitter::Api.get_token to generate the access_token that is going to be used for all the API requests that are being sent to twitter.

### Configuration Instructions

For local environment or deployment, it is required that the administrator is able to go into the app/config/settings.json file and update the values that are needed in that particular file. The structure of the json file along with its keys is the following:

```json
{
	"twitter": {
		"host": "api.twitter.com",
		"version": "1.1",
		"app_key": "7b878fhfdjsh87n",
		"secret": "jhdagHJDGa87398dndajkjhhSHJka",
		"max_count": 25
	},
	"cache": 5
}
```

Most of the keys are self-explanatory where you have to specify the twitter host name (not including http:// or https://), the current twitter's API version and your twitter's application key and secret. Besides that the max_count refers to the max amount of records that is going to be requested to twitter api at a time. 'Cache' key refers to the amount of time, in minutes, that the rails application is going to cache twitter's responses in order to avoid hammering the Twitter API.

### Local Environment Setup

1. You need to have installed ruby 2.3.0 with rails 4.5.0
2. Run **bundle install** in the application's directory
3. Be sure you have updated/created the app/config/settings.json file
3. Run **rails s** to start a local server accessible at http://localhost:3000

### Heroku Deployment instructions

1. Configure Database in Gemfile to be **pg** and comment out the **sqlite3** gem.
2. Modify the config/database.yml file to configure postgresql
3. Run **heroku create** command
4. Push your code to Heroku using git
5. If its the first time deploying, be sure to run migrations or reset in Heroku. If its the first time just run **heroku run rake db:reset** command
6. You can run **heroku open** to get a browser open the website for you

### Test Suite Setup/Execution Instructions

1. Run **bundle install** if not done already
2. Run **rspec spec** to run the test suite

### Heroku Deployment Test

This app has been deployed to https://gentle-citadel-96093.herokuapp.com for testing purposes
