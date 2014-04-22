require 'spec_helper'

describe BooksController do

  include_context "login"
  let(:book) { Fabricate :perfect_ruby }
  let(:valid_params) { { "name" => "リーダブルコード", "isbn" => "978-4873115658", "owner" => user.to_param } }
  let(:update_params) { { "name" => "Perfect Ruby" } }

  describe "#index" do
    before { get :index, auth_token: user.auth_token }
    subject { JSON.parse response.body }

    it { should include "books" }
  end

  describe "#show" do
    before { get :show, { id: book.to_param, auth_token: user.auth_token } }
    subject { JSON.parse(response.body)["book"] }

    its(["name"]) { should eq book.name }
    its(["isbn"]) { should eq book.isbn }
  end

  describe "#create" do
    before { post :create, { book: valid_params, auth_token: user.auth_token } }
    subject { JSON.parse(response.body)["book"] }

    its(["name"]) { should eq valid_params["name"] }
    its(["isbn"]) { should eq valid_params["isbn"] }
  end

  describe "#update" do
    before { patch :update, { id: book.to_param, book: update_params, auth_token: user.auth_token } }
    subject { JSON.parse(response.body)["book"] }

    its(["name"]) { should eq update_params["name"] }
  end

  describe "#destroy" do
    before { delete :destroy, { id: book.to_param, auth_token: user.auth_token } }
    subject { Book.exists?(book.id) }

    it { should be_false }
  end

end
