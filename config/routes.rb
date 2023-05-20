Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :auth do
    collection do
      post 'login'
      post 'register'
      get  'profile'
    end
  end

  namespace :admin do
    resources :courses
    resources :users
  end
end
