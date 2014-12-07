require 'rails_helper'

describe User, type: :model do
  let(:app) { FactoryGirl.create(:app) }

  context 'with cached apps' do
    let(:user) { FactoryGirl.create(:user, apps: [app]) }

    it '#apps' do
      expect(user.apps).to eq [app]
    end

    it '#not_cached_apps' do
      expect(user.not_cached_apps).to be_empty
    end
  end

  context 'without cached apps' do
    let(:user) { FactoryGirl.create(:user) }

    it '#apps' do
      expect(user.apps).to be_empty
    end

    it '#not_cached_apps' do
      expect(user.not_cached_apps).to eq [app]
    end
  end
end
