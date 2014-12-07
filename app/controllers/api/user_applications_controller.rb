class API::UserApplicationsController < ApplicationController
  # Since we don't need to worry about authentication at this moment, the app will rely
  # on devise to get the current user and also authenticate requests.
  # This API will be used by our javascript file to make AJAX requests

  # Returns the current list of applications
  def applications
    render json: App.all, status: 200
  end

  # Saves the cached applications for the current user
  def applications_user_save
    user = User.find(current_user.id)

    # If update is successful reloads the current user in session
    if user.update(app_ids: params[:app_ids])
      sign_in user, bypass: true
    end

    # Returns an array containing cached and non cached apps for the user
    render json: current_user.to_json(only: [], methods: [:apps, :not_cached_apps]), status: 200
  end
end
