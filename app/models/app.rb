class App < ActiveRecord::Base
  has_many :user_applications
  has_many :users, through: :user_applications
end
