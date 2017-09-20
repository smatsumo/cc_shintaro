Rails.application.routes.draw do
  root 'users#profiles'
  
  
  get '/likes', to:'users#likes',as: :likes
  get '/products', to:'users#products', as: :products
  get '/users/products/new', to:'users#new', as: :products_new
  post '/users/products/new', to: 'users#sell_item'
  get '/sign_in', to:'users#sign_in', as: :sign_in
  post 'sign_in', to: "users#sign_in_process"
  get '/sign_up', to:'users#sign_up', as: :sign_up
  post '/sign_up',to:'users#sign_up_process'
  get '/sign_out', to:'users#sign_out', as: :sign_out
  get 'markets/(:id)/payment',to:'markets#payment', as: :payments
  get '/profiles/edit', to:'users#edit',as: :profile_edit
  post 'profiles/edit', to:'users#update'
  patch 'profiles/edit', to:'users#update'
  get '/profiles', to:'users#profiles', as: :top

  

  
end
