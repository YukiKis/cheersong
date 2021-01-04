Rails.application.routes.draw do
  scope module: :public do
    resources :users do
      member do
        post "/follow", to: "users#follow", as: :follow
        delete "/unfollow", to: "users#unfollow", as: :unfollow
      end
    end
  end
  devise_for :users, controllers: {
      sessions: "public/users/sessions",
      registrations: "public/users/registrations"
    }
  root "home#home"
  get '/about', to: "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
