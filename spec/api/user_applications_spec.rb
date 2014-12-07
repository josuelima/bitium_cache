require 'rails_helper'

describe API::UserApplicationsController, type: :controller do
  context 'user not authenticated' do
    it 'GET /api/applications returns 302' do
      get :applications, {}
      expect(response.status).to eq 302
    end

    it 'POST /api/applications returns 302' do
      post :applications, {}
      expect(response.status).to eq 302
    end
  end

  context 'user authenticated' do
    login_user
    let!(:app) { FactoryGirl.create(:app) }

    it 'GET /api/applications returns list of apps' do
      get :applications, {}
      expect(response.status).to eq 200
      expect(response.body).to eq [app].to_json
    end

    it 'POST /api/applications associates apps to user and returns cached and non cahed' do
      post :applications_user_save, {app_ids: [app.id]}
      expect(response.status).to eq 200
      expect(@current_user.apps).to eq [app]
      expect(response.body).to eq ({apps: [app], not_cached_apps: []}).to_json
    end
  end
end
