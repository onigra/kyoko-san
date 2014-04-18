require 'spec_helper'

describe BooksController do
  include Rack::Test::Methods

  include_context "login"
  let(:book) { Fabricate :perfect_ruby }
  let(:valid_params) { { "name" => "リーダブルコード", "isbn" => "978-4873115658" } }
  let(:update_params) { { "name" => "Perfect Ruby" } }

  describe "GET /books" do
    it "return 200" do
      get "/books", auth_token: user.auth_token
      expect(last_response.status).to eq 200
    end
  end

  describe "GET /books/:id" do
    it "return 200" do
      get "/books/#{book.to_param}", auth_token: user.auth_token
      expect(last_response.status).to eq 200
    end
  end

  describe "POST /books" do
    it "return 200" do
      post "/books", { book: valid_params, auth_token: user.auth_token }
      expect(last_response.status).to eq 200
    end
  end

  describe "PATCH /books/:id" do
    it "return 200" do
      patch "/books/#{book.to_param}", { book: update_params, auth_token: user.auth_token }
      expect(last_response.status).to eq 200
    end
  end

  describe "DELETE /books/:id" do
    it "return 200" do
      delete "/books/#{book.to_param}", auth_token: user.auth_token
      expect(last_response.status).to eq 200
    end
  end

end
