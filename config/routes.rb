LineUp::Application.routes.draw do
  captcha_route

  root to: 'home#index'
  match 'offer', to: 'user_queue#create', via: :post
  match 'login', to: 'session#login', :via => [:get]
  match 'login', to: 'session#create', :via => [:post]
  match 'logout', to: 'session#destroy', :via =>[:get]
  namespace :system do
    resources :queues
    resources :recodes ,only: [:index]
    resources :users_queue
  end


end
