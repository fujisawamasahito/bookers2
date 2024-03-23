Rails.application.routes.draw do

    devise_for :users
    root to: "homes#top"
    get 'home/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update] do
     resource :favorites, only: [:create, :destroy]
     resources :book_comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create, :destroy]
end
