Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :admin do
    resources :auth do
      collection do
        post 'login'
        post 'register'
        get  'profile'
      end
    end
    
    resources :courses
    resources :users
    resources :enrollments
    resources :orders

    namespace :organization do
      resources :orders
    end
  end
end
