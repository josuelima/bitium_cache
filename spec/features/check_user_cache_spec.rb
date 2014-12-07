require 'rails_helper'

feature 'check user cache' do
  let(:user_1) { FactoryGirl.create(:user) }
  # Here we use a local asset located on our app to test the javascript result
  let(:app)    { FactoryGirl.create(:app, resource: 'http://localhost:31337/assets/application.css') }
  let(:user_2) { FactoryGirl.create(:user, app_ids: [app.id]) }

  context 'not signed in' do
    scenario 'sign in with email and password' do
      visit '/'

      fill_in 'Email', with: user_1.email
      fill_in 'Password', with: user_1.password

      click_button 'Log in'
      expect(page).to have_content "Welcome #{user_1.email}"
    end
  end

  context 'signed in' do
    scenario 'show apps not cached' do
      login_as(user_1, scope: :user)
      visit '/'
      expect(page).to have_content "Not visited: #{app.application}"
    end

    scenario 'show apps cached' do
      login_as(user_2, scope: :user)
      visit '/'
      expect(page).to have_content "Visited: #{app.application}"
    end
  end
end
