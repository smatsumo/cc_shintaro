Rails.application.routes.draw do


  get 'users/sign_in_process'

  root 'users#top'
  get '/sign_up',to:'users#sign_up',as: :sign_up
  post '/sign_up',to:'users#sign_up_process'
  
  get '/sign_in',to:'users#sign_in',as: :sign_in

  get '/follow_list/(:id)', to:'users#follow_list',as: :follow_list
  get '/follower_list/(:id)', to:'users#follower_list',as: :follower_list
  
  get 'posts/new', to:'posts#new', as: :new_post
  resources :posts

  
  get 'profile/(:id)', to:'users#show',as: :profile
  get 'profile/edit', to:'users#edit',as: :profile_edit
  get 'top', to:'users#top', as: :top
  
  
end
