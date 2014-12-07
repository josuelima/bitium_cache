class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_applications
  has_many :apps, through: :user_applications
  accepts_nested_attributes_for :apps

  def not_cached_apps
    apps.empty? ? App.all : App.where('id not in (?)', apps.map(&:id))
  end
end
