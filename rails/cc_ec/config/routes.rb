Rails.application.routes.draw do
  root 'users#item_list'
  
  get '/', to:'users#item_list', as: :item_list
  get '/likes/(:id)/like', to:'users#likes',as: :likes
  get '/users/likes', to:'users#likes_list',as: :likes_item_list

  get '/users/products', to:'users#products', as: :products
  get '/users/products/new', to:'users#new', as: :products_new
  post '/users/products/new', to: 'users#sell_item'
  patch '/users/products/new', to:'users#sell_item'
  get '/users/products/(:id)', to:'users#user_item_detail', as: :user_item_detail
  get '/users/products/(:id)/edit', to:'users#user_item_edit', as: :item_edit_page
  patch '/users/products/(:id)/edit', to:'users#item_edit',as: :item_edit

  get '/sign_in', to:'users#sign_in', as: :sign_in
  post 'sign_in', to: "users#sign_in_process"
  get '/sign_up', to:'users#sign_up', as: :sign_up
  post '/sign_up',to:'users#sign_up_process'
  get '/sign_out', to:'users#sign_out', as: :sign_out
  get '/markets/(:id)',to:'markets#item_detail', as: :item_detail
  get '/markets/(:id)/payment',to:'markets#payment', as: :payment
  get '/profiles/edit', to:'users#edit',as: :profile_edit
  patch 'profiles/edit', to:'users#update'
  get '/profiles', to:'users#profiles', as: :top

  

  
end
