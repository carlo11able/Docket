Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations",
                                       :omniauth_callbacks => "users/omniauth_callbacks"}
  #devise_for :users



  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get ('/login') => redirect(:login) 
  get ("/") => redirect("users")
  
  get "/home" => "users#smistamento"

  # resources :photos ,:shallow => true do 
  #   resources :questions
  # end
  resources :photos do 
    resources :questions 
  end

  resources :answers

  #resources :users [:show, :update, :destroy]
  resources :users
end
