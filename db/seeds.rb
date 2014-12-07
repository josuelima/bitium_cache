# Creates a tester so you don't need to
User.create(email: 'email@email.com',
            password: 'supersecret',
            password_confirmation: 'supersecret')

# Applications
apps = [
  {application: 'Bitium', resource: 'https://www.bitium.com/site/stylesheets/screen.css'},
  {application: 'Github', resource: 'https://assets-cdn.github.com/images/modules/open_graph/github-logo.png'},
  {application: 'AmazonWS', resource: 'https://a0.awsstatic.com/main/css/1.0.79/style.css'},
  {application: 'Rackspace - Customer Portal', resource: 'https://mycloud.rackspace.com/site_media/images/rackspace_favicon.png'},
  {application: 'Twitter', resource: 'https://abs.twimg.com/favicons/favicon.ico'}
]

apps.each { |app| App.create(app) }
