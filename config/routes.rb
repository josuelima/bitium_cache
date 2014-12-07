Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    get  '/applications', to: 'user_applications#applications'
    post '/applications', to: 'user_applications#applications_user_save'
  end
end
