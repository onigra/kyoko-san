class BookSerializer < ActiveModel::Serializer
  attributes :id, :name, :isbn
end
