class BookSerializer < ActiveModel::Serializer
  attributes :id, :name, :isbn, :owner
end
