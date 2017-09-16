Rails.application.routes.draw do

  #get 'static_pages/top'
  root 'static_pages#top'
  #get '/tweets', to:'tweets#new'
  get '/tweets', to:'tweets#new', as: 'new_tweet'
  post '/tweets/create', to:'tweets#create'
  get '/contacts', to:'contacts#ask'
  post '/contacts/create', to:'contacts#create'

end
