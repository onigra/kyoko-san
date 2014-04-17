require 'spec_helper'
describe BooksController do
  let(:valid_attributes) { { "name" => "MyString", "isbn" => "12345" } }

  describe "GET index" do
    it "assigns all books as @books" do
      book = Book.create! valid_attributes
      get :index
      assigns(:books).should eq([book])
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :show, {:id => book.to_param}
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, {:book => valid_attributes}
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => valid_attributes}
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        Book.any_instance.stub(:save).and_return(false)
        post :create, {:book => { "name" => "invalid value" }}
        assigns(:book).should be_a_new(Book)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book" do
        book = Book.create! valid_attributes
        Book.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => book.to_param, :book => { "name" => "MyString" }}
      end

      it "assigns the requested book as @book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}
        assigns(:book).should eq(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        book = Book.create! valid_attributes
        Book.any_instance.stub(:save).and_return(false)
        put :update, {:id => book.to_param, :book => { "name" => "invalid value" }}
        assigns(:book).should eq(book)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete :destroy, {:id => book.to_param}
      }.to change(Book, :count).by(-1)
    end
  end

end
