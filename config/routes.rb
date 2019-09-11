Rails.application.routes.draw do

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get ('/login') => redirect(:login) 
  get ("/") => redirect("users")

  resources :users
end
