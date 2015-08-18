require 'rails_helper'

describe MessagesController do
  
  describe 'GET #show' do
    it "assigns the requested message to @message" do
      message = create(:message)
      get :show, id: message
      expect(assigns(:message)).to eq message
    end

    it "renders the :show template" do
      message = create(:message)
      get :show, id: message
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
  
  describe 'GET #new' do
    it "assigns a new Massage to @massage" do
      get :new
      expect(assigns(:message)).to be_a_new(Message)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end
 
  describe 'GET #edit' do
    it "assigns the requested massage to @massage" do
      message = create(:message)
      get :edit, id: message
      expect(assigns(:message)).to eq message
    end

    it "renders the :edit template" do
      message = create(:message)
      get :edit, id: message
      expect(response).to render_template :edit
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new message in the database" do
        expect{ post :create, message: attributes_for(:message) }.to change(Message, :count).by(1)
      end

      it "redirects to #index" do
        post :create, message: attributes_for(:message)
        expect(response).to redirect_to :action => :index
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new message in the database" do
        expect{
          post :create,
          message: attributes_for(:invalid_message)
        }.not_to change(Message, :count)
      end

      it "re-renders the :new template" do
        post :create,
        message: attributes_for(:invalid_message)
        expect(response).to render_template :new
      end
    end    
  end
  
  describe 'PATCH #update' do
    before :each do
      @message = create(:message, title: 'titletest', body: 'bodytest')
    end

    context "valid attributes" do
      it "locates the requested @message" do
        patch :update, id: @message, message: attributes_for(:message)
        expect(assigns(:message)).to eq(@message)
      end

      it "changes @message's attributes" do
        patch :update, id: @message,
        message: attributes_for(:message, title: 'titletest', body: 'bodytest')
        @message.reload
        expect(@message.title).to eq('titletest')
        expect(@message.body).to eq('bodytest')
      end

      it "redirects to the updated message" do
        patch :update, id: @message, message: attributes_for(:message)
        expect(response).to redirect_to :action => :index
      end
    end
    
    context "with invalid attributes" do
      it "does not change the message's attributes" do
        patch :update, id: @message,
        message: attributes_for(:message, title: nil, body: 'bodytest')
        @message.reload
        expect(@message.title).to eq("titletest")
        expect(@message.body).to eq("bodytest")
      end

      it "re-renders the :edit template" do
        patch :update, id: @message,
        message: attributes_for(:invalid_message)
        expect(response).to render_template :edit
      end
    end
  end
  
  describe 'DELETE #destroy' do
    before :each do
      @message = create(:message)
    end

    it "deletes the message" do
      expect{ delete :destroy, id: @message }.to change(Message, :count).by(-1)
    end
    
    it "redirects to #index" do
      delete :destroy, id: @message
      expect(response).to redirect_to :action => :index
    end
  end
  
end