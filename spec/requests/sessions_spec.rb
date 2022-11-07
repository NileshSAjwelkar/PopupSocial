require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:email) { "randomemail@socialnetwork.com" }
  let(:password) { "randomPassword" }

  let :credentials do
    { :user => { :email => email, :password => password } }
  end

  describe "GET /login" do
    it "renders login template" do
      get "/login"
      expect(response).to render_template('sessions/new')
    end
  end

  describe "POST /login" do
    it "creates session if creds are valid" do
      new_user = create(:user, email: email, password: password, password_confirmation: password) 

      post "/login" , params: credentials
      expect(session[:current_user_id]).to(eq(new_user.id))
    end

    it "creates session if creds are valid" do
      new_user = create(:user, email: email, password: "wrongpassword", password_confirmation: "wrongpassword") 
      
      post "/login" , params: credentials
      expect(session[:current_user_id]).to be_nil
    end
  end

  describe "DELETE /logout" do
    it "returns http success" do
      delete "/logout"
      expect(session[:current_user_id]).to be_nil
    end
  end

end
