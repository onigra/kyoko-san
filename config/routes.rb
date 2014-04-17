Libmaster::Application.routes.draw do
  resources :books, except: [:new, :edit]
end
