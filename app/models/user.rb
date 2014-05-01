class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :books, foreign_key: :owner

  def generate_token(column = "auth_token")
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
    self.save
  end

  def destroy_token
    self.update(auth_token: nil)
  end
end
