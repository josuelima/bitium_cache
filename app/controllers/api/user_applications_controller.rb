class API::UserApplicationsController < ApplicationController
  # since we don't need to worry about authentication at this moment, the app will rely
  # on devise to get the current user and also authenticate requests

  # returns the current list of applications
  def applications
    render json: App.all, status: 200
  end

  # saves the cached applications for the current user
  def applications_user_save
    user = User.find(current_user.id)

    # if update is successful, reloads the current user in session, then returns
    # an array of cached and non cached apps for the user
    if user.update(app_ids: params[:app_ids])
      sign_in user, bypass: true
    end

    render json: current_user.to_json(only: [], methods: [:apps, :not_cached_apps]), status: 200
  end
end
