LineUp::Application.routes.draw do
  root to: 'home#index'
  match 'offer', to: 'user_queue#create', via: :post
end
