Fabricator :sample_user, class_name: User do
  email { Forgery(:email).address }
  # password { Forgery(:basic).password(:at_least => 9, :at_most => 10) }
  password "password"
end
