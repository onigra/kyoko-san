class Book < ActiveRecord::Base
  belongs_to :user, foreign_key: :id
end
