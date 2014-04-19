require 'spec_helper'

describe SessionsController do

  let(:user) { Fabricate :sample_user }

  describe "#create" do
    before { post :create, email: user.email, password: "password" }
    let(:res) { JSON.parse response.body }

    it "response include auth_token" do
      expect(res["user"]).to include "auth_token"
    end

    it "auth_token is created" do
      expect(res["user"]["auth_token"]).to eq user.reload.auth_token
    end
  end

  describe "#destroy" do
    include_context "login"
    before { delete :destroy, auth_token: user.auth_token }

    it "auth token should be nil" do
      expect(user.reload.auth_token).to be_nil
    end
  end

end
