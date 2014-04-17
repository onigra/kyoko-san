class User < ActiveRecord::Base
  authenticates_with_sorcery!

  def generate_token(column = "auth_token")
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
    self.save
  end

  def destroy_token
    self["auth_token"] = nil
    self.save
  end
end
