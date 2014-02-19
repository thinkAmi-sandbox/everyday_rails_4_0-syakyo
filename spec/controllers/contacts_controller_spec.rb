require 'spec_helper'

describe ContactsController do
  
  describe 'GET #index' do
    context 'with param[:letter]' do
      it "populates an array of contacts starting with the letter" do
        smith = FactoryGirl.create(:contact, lastname: 'Smith')
        jones = FactoryGirl.create(:contact, lastname: 'Jones')
        get :index, letter: 'S'

        expect(assigns(:contacts)).to match_array([smith])
      end

      it "renders the :index view" do
        get :index, letter: 'S'

        expect(response).to render_template :index
      end
    end


    context 'without params[:letter]' do
      it "populates an array of all contacts" do
        smith = FactoryGirl.create(:contact, lastname: 'Smith')
        jones = FactoryGirl.create(:contact, lastname: 'Jones')
        get :index

        expect(assigns(:contacts)).to match_array([smith, jones])
      end


      it "renders the :index view" do
        get :index

        expect(response).to render_template :index
      end
    end
  end


  describe 'GET #show' do
    it "assigns the requested contact to @contact" do
      contact = FactoryGirl.create(:contact)
      get :show, id: contact

      expect(assigns(:contact)).to eq contact
    end

    it "renders the :show template" do
      contact = FactoryGirl.create(:contact)
      get :show, id: contact

      expect(response).to render_template :show
    end
  end


  describe 'GET #new' do
    it "assigns a new Contact to @contact" do
      get :new

      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it "renders the :new template" do
      get :new

      expect(response).to render_template :new
    end
  end


  describe 'GET #edit' do
    it "assigns the requested contact to @contact" do
      contact = FactoryGirl.create(:contact)
      get :edit, id: contact

      expect(assigns(:contact)).to eq contact
    end

    it "renders the :edit template" do
      contact = FactoryGirl.create(:contact)
      get :edit, id: contact

      expect(response).to render_template :edit
    end
  end


  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new contact in the database"

      it "redirects to contacts#show"
    end


    context "with invalid attributes" do
      it "does not save the new contact in the database"

      it "renders the :new template"
    end
  end


  describe 'PUT #update' do
    context "with valid attributes" do
      it "updates the contact in the database"

      it "redirects to the contact"
    end


    context "with invalid attributes" do
      it "does not update the contact"


      it "re-renders the :edit template"
    end
  end


  describe 'PUT #update' do
    it "deletes the contact from the database"

    it "redirects to contacts#index"
  end
end