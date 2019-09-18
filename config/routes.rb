Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations",
                                       :omniauth_callbacks => "users/omniauth_callbacks"}
  #devise_for :users


  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get ('/login') => redirect(:login) 
  get ("/") => redirect("users")
  
  get "/home" => "users#smistamento"

  get "users/customers" => "users#customers"

  get "users/labelers" => "users#labelers"

  
  resources :photos do 
    resources :questions 
  end

  resources :answers

  get "answers/question/:id" => "answers#nuova"

  #resources :users [:show, :update, :destroy]
  resources :users, only: [:index, :show, :destroy]


  match "*path", :to => "errors#internal_server_error", :via => :all

end
