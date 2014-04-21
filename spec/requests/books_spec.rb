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
    context "success" do
      it "return book" do
        get "/books/#{book.to_param}", auth_token: user.auth_token
        expect(last_response.status).to eq 200
      end
    end

    context "user not found" do
      it "return 404" do
        get "/books/99999999", auth_token: user.auth_token
        expect(last_response.status).to eq 404
      end
    end
  end

  describe "POST /books" do
    let(:valid_params) { { "name" => "リーダブルコード", "isbn" => "978-4873115658" } }
    let(:invalid_params) { { "book_name" => "リーダブルコード" } }

    context "valid parameters" do
      it "create a new book" do
        post "/books", { book: valid_params, auth_token: user.auth_token }
        expect(last_response.status).to eq 201
      end
    end

    context "invalid parameters" do
      it "return 400" do
        post "/books", { book: invalid_params, auth_token: user.auth_token }
        expect(last_response.status).to eq 400
      end
    end

    context "save failed" do
      it "return 500" do
        Book.any_instance.stub(:save).and_return(false)
        post "/books", { book: valid_params, auth_token: user.auth_token }
        expect(last_response.status).to eq 500
      end
    end
  end

  describe "PATCH /books/:id" do
    let(:update_params) { { "name" => "Perfect Ruby" } }
    let(:invalid_params) { { "book_name" => "リーダブルコード" } }

    context "valid parameters" do
      it "update a book" do
        patch "/books/#{book.to_param}", { book: update_params, auth_token: user.auth_token }
        expect(last_response.status).to eq 200
      end
    end

    context "invalid parameters" do
      it "return 400" do
        post "/books", { book: invalid_params, auth_token: user.auth_token }
        expect(last_response.status).to eq 400
      end
    end

    context "save failed" do
      it "return 500" do
        Book.any_instance.stub(:update).and_return(false)
        patch "/books/#{book.to_param}", { book: update_params, auth_token: user.auth_token }
        expect(last_response.status).to eq 500
      end
    end
  end

  describe "DELETE /books/:id" do
    context "success" do
      it "destroy a book" do
        delete "/books/#{book.to_param}", auth_token: user.auth_token
        expect(last_response.status).to eq 204
      end
    end

    context "save failed" do
      it "return 500" do
        Book.any_instance.stub(:destroy).and_return(false)
        delete "/books/#{book.to_param}", auth_token: user.auth_token
        expect(last_response.status).to eq 500
      end
    end
  end

end
