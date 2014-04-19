Rails.application.routes.draw do
  resources :books, except: [:new, :edit]

  post 'login' => "sessions#create", :as => :login
  delete 'logout' => "sessions#destroy", :as => :logout
end
