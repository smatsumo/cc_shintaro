Rails.application.routes.draw do

  root 'users#top'
  get '/sign_up',to:'users#sign_up',as: :sign_up
  post '/sign_up',to:'users#sign_up_process'
  
  get '/sign_in', to: 'users#sign_in', as: :sign_in
  post '/sign_in',to:'users#sign_in_process'
  
  get '/sign_out', to:'users#sign_out', as: :sign_out

  get '/follow_list/(:id)', to:'users#follow_list',as: :follow_list
  get '/follower_list/(:id)', to:'users#follower_list',as: :follower_list
  
  get '/follow/(:id)', to:'users#follow', as: :follow
  

  #resourceはrouteに置ける基本的なルートを自動的に構築してくれる（index,update,destroy,edit等)
  resources :posts do
    member do
      # いいね
      get 'like', to: 'posts#like', as: :like
      #post 'like', to: 'posts#like', as: :like
      post 'comment', to: 'posts#comment', as: :comment
    end
  end
  
  #ルーティングの順序に注意 理由が分からない。。。
  get 'profiles/edit', to:'users#edit',as: :profile_edit
  post 'profiles/edit', to:'users#update'
  get 'profile/(:id)', to:'users#show',as: :profile
  
  get 'top', to:'users#top', as: :top
  
  
end
