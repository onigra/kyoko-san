require 'spec_helper'

describe "BooksController's Requests" do
  include Rack::Test::Methods

  include_context "login"
  let(:book) { Fabricate :perfect_ruby }

  describe "GET /books" do
    it "return books" do
      get "/books", auth_token: user.auth_token
      expect(last_response.status).to eq 200
    end
  end

  describe "GET /books/:id" do
    it "return book" do
      get "/books/#{book.to_param}", auth_token: user.auth_token
      expect(last_response.status).to eq 200
    end
  end

  describe "POST /books" do
    let(:valid_params) { { "name" => "リーダブルコード", "isbn" => "978-4873115658" } }

    it "create a new book" do
      post "/books", { book: valid_params, auth_token: user.auth_token }
      expect(last_response.status).to eq 201
    end
  end

  describe "PATCH /books/:id" do
    let(:update_params) { { "name" => "Perfect Ruby" } }

    it "update a book" do
      patch "/books/#{book.to_param}", { book: update_params, auth_token: user.auth_token }
      expect(last_response.status).to eq 200
    end
  end

  describe "DELETE /books/:id" do
    it "destroy a book" do
      delete "/books/#{book.to_param}", auth_token: user.auth_token
      expect(last_response.status).to eq 204
    end
  end

end
