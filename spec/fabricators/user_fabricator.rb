Fabricator :sample_user, class_name: User do
  name { Forgery(:internet).user_name }
  email { Forgery(:email).address }
  password "password"
end
