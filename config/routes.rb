LineUp::Application.routes.draw do
  captcha_route

  root to: 'home#index'
  match 'offer', to: 'user_queue#create', via: :post
  match 'login', to: 'session#login', :via => [:get]

  resources :system

end
