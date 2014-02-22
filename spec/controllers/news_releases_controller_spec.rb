require 'spec_helper'

describe NewsReleasesController, focus: true do
  describe 'GET #new' do
    it "requires login" do
      get :new
      expect(response).to require_login
    end
  end


  describe 'GET #create' do
    it "requires login" do
      post :create, news_release: FactoryGirl.attributes_for(:news_release)
      expect(response).to require_login
    end
  end
end