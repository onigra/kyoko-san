require 'spec_helper'

describe "SessionsController's Requests" do
  include Rack::Test::Methods

  describe "POST /login" do
    let(:user) { Fabricate :sample_user }

    it "return auth token" do
      post "/login", email: user.email, password: "password"
      expect(last_response.status).to eq 201
    end
  end

  describe "DELETE /logout" do
    include_context "login"

    it "destroy auth token" do
      delete "/logout", auth_token: user.auth_token
      expect(last_response.status).to eq 204
    end
  end

end
