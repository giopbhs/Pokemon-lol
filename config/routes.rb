Rails.application.routes.draw do

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
    resources :comments
  end

  root "pins#index"

end
