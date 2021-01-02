Rails.application.routes.draw do
  scope module: :public do

  end
  devise_for :users, controllers: {
      sessions: "public/users/sessions",
      registrations: "users/registrations"
    }
  root "home#home"
  get '/about', to: "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
