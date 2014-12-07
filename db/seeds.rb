# Creates a tester so you don't need to
User.create(email: 'email@email.com',
            password: 'supersecret',
            password_confirmation: 'supersecret')

# Applications
apps = [
  {application: 'Bitium', resource: 'https://www.bitium.com/site/stylesheets/screen.css'},
  {application: 'Github', resource: 'https://assets-cdn.github.com/assets/github-2a88a7bf0ff1b660d7ff29c3220a68751650b37fc53d40d3a7068e835fd213ec.css'},
  {application: 'AmazonWS', resource: 'https://a0.awsstatic.com/main/css/1.0.79/style.css'},
  {application: 'Rackspace - Customer Portal', resource: 'https://0ffddf3700fca63d7eee-f2158e9965ca1e4dc7433839c207ae5c.ssl.cf1.rackcdn.com/login-6a937b0eadae699bbb6056b6e939a78ddb3e4606.css'},
  {application: 'Twitter', resource: 'https://abs.twimg.com/a/1417652304/css/t1/twitter_core.bundle.css'}
]

apps.each { |app| App.create(app) }
