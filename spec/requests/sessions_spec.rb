require 'spec_helper'

describe "SessionsController's Requests" do
  include Rack::Test::Methods

  describe "POST /login" do
    let(:user) { Fabricate :sample_user }

    context "success" do
      it "return auth token" do
        post "/login", email: user.email, password: "password"
        expect(last_response.status).to eq 201
      end
    end

    context "fail" do
      context "incorrect password" do
        it "return 400 user not found" do
          post "/login", email: user.email, password: "foobarbaz"
          expect(last_response.status).to eq 401
        end
      end

      context "unknown user" do
        it "return 400 user not found" do
          post "/login", email: "foobarbaz@example.com", password: "foobarbaz"
          expect(last_response.status).to eq 401
        end
      end
    end

    context "missing parameters" do
      it "return 400" do
        post "/login", email: user.email
        expect(last_response.status).to eq 400
      end
    end

  end

  describe "DELETE /logout" do
    include_context "login"

    context "success" do
      it "destroy auth token" do
        delete "/logout", auth_token: user.auth_token
        expect(last_response.status).to eq 204
      end
    end

    context "fail" do
      context "invalid auth token" do
        it "return 400 user not found" do
          delete "/logout", auth_token: "abcde"
          expect(last_response.status).to eq 401
        end
      end
    end

    context "missing parameters" do
      it "return 400" do
        delete "/logout"
        expect(last_response.status).to eq 400
      end
    end
  end

end
