Rails.application.routes.draw do

  get 'pages/about'

  get 'pages/credits'

  get 'pages/resources'

  get 'pages/nostalgia'
  get 'pages/pokedex'

  resources :coments
  resources :comments
  resources :links do
  	member do
  		put "like",    to: "links#upvote"
  		put "dislike", to: "links#downvote"
  	end
    resources :comments
  end

  devise_for :users
  resources :pins do
  	member do
  		put "like", to: "pins#upvote"
  		put "dislike", to: "pins#downvote"
  	end
    resources :coments
  end

  root "pins#index"

  #Users show route

  resources :users, only: [:show, :index]

  resources :videos, only: [:index, :new, :create]

    resources :videos do
    member do
      put "like", to: "videos#upvote"
      put "dislike", to: "videos#downvote"
    end
  end


  
end
