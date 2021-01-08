Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: "public/users/sessions",
      registrations: "public/users/registrations"
  }
  scope module: :public do
    resources :users do
      post "/follow", to: "users#follow", as: :follow
      delete "/unfollow", to: "users#unfollow", as: :unfollow
      get "/followers", to: "users#followers", as: :followers
      get "/followings", to: "users#followings", as: :followings
      resources :rooms, only: [:create, :show, :index] do
        resources :messages, only: [:create]
      end
    end
    resources :songs do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  root "home#home"
  get '/about', to: "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
