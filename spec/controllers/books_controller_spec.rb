require 'spec_helper'

describe BooksController do
  let(:valid_attributes) { { "name" => "MyString", "isbn" => "12345" } }
  let(:book) { Book.create! valid_attributes }
  before { book }

  describe "GET index" do
    it "assigns all books as @books" do
      get :index
      expect(assigns :books).to eq [book]
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      get :show, { :id => book.to_param }
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, { :book => valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, { :book => valid_attributes }
        expect(assigns :book).to be_a Book
        expect(assigns :book).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        Book.any_instance.stub(:save).and_return(false)
        post :create, { :book => { "name" => "invalid value" } }
        expect(assigns :book).to be_a_new Book
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book" do
        put :update, { :id => book.to_param, :book => { "name" => "MyString" } }
        expect(assigns(:book).name).to eq "MyString"
      end

      it "assigns the requested book as @book" do
        put :update, {:id => book.to_param, :book => valid_attributes}
        expect(assigns :book).to eq book
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => { "name" => "invalid value" }}
        expect(assigns :book).to eq book
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book" do
      expect {
        delete :destroy, {:id => book.to_param}
      }.to change(Book, :count).by(-1)
    end
  end

end
