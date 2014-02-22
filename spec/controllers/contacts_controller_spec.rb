require 'spec_helper'

describe ContactsController do
  shared_examples("public access to contacts") do
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
  end


  shared_examples('full access to contacts') do
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
      before :each do
        @phones = [
          FactoryGirl.attributes_for(:phone),
          FactoryGirl.attributes_for(:phone),
          FactoryGirl.attributes_for(:phone)
        ]
      end


      context "with valid attributes" do
        it "saves the new contact in the database" do
          expect{
            post :create, 
                 contact: FactoryGirl.attributes_for(:contact,
                                                     phones_attributes: @phones )
          }.to change(Contact, :count).by(1)
        end

        it "redirects to contacts#show" do
          post :create, 
               contact: FactoryGirl.attributes_for(:contact,
                                                   phones_attributes: @phones)
          expect(response).to redirect_to contact_path(assigns[:contact])
        end
      end


      context "with invalid attributes" do
        it "does not save the new contact in the database" do
          expect{
            post :create,
                 contact: FactoryGirl.attributes_for(:invalid_contact)
          }.to_not change(Contact, :count)
        end

        it "renders the :new template" do
          post :create,
               contact: FactoryGirl.attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end
      end
    end


    describe 'PATCH #update' do
      before :each do
        @contact = FactoryGirl.create(:contact,
                                      firstname: 'Lawrence',
                                      lastname:  'Smith')
      end

      context "valid attributes" do
        it "located the requested @contact" do
          patch :update,
                id: @contact,
                contact: FactoryGirl.attributes_for(:contact)

          expect(assigns(:contact)).to eq(@contact)
        end


        it "changes @contact's attributes"  do
          patch :update,
                id: @contact,
                contact: FactoryGirl.attributes_for(:contact,
                                                    firstname: "Larry",
                                                    lastname:  "Smith")
          @contact.reload

          expect(@contact.firstname).to eq("Larry")
          expect(@contact.lastname).to eq("Smith")
        end


        it "redirects to the updated contact" do
          patch :update,
                id: @contact,
                contact: FactoryGirl.attributes_for(:contact)
          expect(response).to redirect_to @contact
        end
      end


      context "with invalid attributes" do
        it "does not update the contact's attributes" do
          patch :update,
                id: @contact,
                contact: FactoryGirl.attributes_for(:contact,
                                                    firstname: "Larry",
                                                    lastname:  nil)
          @contact.reload

          expect(@contact.firstname).to_not eq("Larry")
          expect(@contact.lastname).to eq("Smith")
        end


        it "re-renders the :edit template" do
          patch :update,
                id: @contact,
                contact: FactoryGirl.attributes_for(:invalid_contact)
          expect(response).to render_template :edit
        end
      end
    end


    describe 'DELETE #update' do
      before :each do
        @contact = FactoryGirl.create(:contact)
      end

      it "deletes the contact" do
        expect{
          delete :destroy, id: @contact
        }.to change(Contact, :count).by(-1)
      end

      it "redirects to contacts#index" do
        delete :destroy, id: @contact
        expect(response).to redirect_to contacts_url
      end
    end
  end


  
  describe "administrator access" do
    before :each do
      user = FactoryGirl.create(:admin)
      session[:user_id] = user.id
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'    
  end


  describe "user access" do
    before :each do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'
  end


  describe "guest access" do
    it_behaves_like 'public access to contacts'

    describe 'GET #new' do
      it "requires login" do
        get :new
        expect(response).to redirect_to login_url
      end
    end


    describe 'GET #edit' do
      it "requires login" do
        contact = FactoryGirl.create(:contact)
        get :edit, id: contact

        expect(response).to redirect_to login_url
      end
    end


    describe 'POST #create' do
      it "requires login" do
        post :create,
             id: FactoryGirl.create(:contact),
             contact: FactoryGirl.attributes_for(:contact)

        expect(response).to redirect_to login_url
      end
    end


    describe 'PATCH #update' do
      it "requires login" do
        patch :update,
              id: FactoryGirl.create(:contact),
              contact: FactoryGirl.attributes_for(:contact)

        expect(response).to redirect_to login_url
      end
    end


    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: FactoryGirl.create(:contact)
        expect(response).to redirect_to login_url
      end
    end
  end
end