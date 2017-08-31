Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post, :delete], :controllers => { :registrations => "registrations" }, :path_prefix => 'auth'
  #resources :users

  resources :people
  #resources :goals
  resources :teams do
    post 'import_okrs', on: :member
    #get 'import_okrs', on: :member
  end

  resources :statuses
  resources :scores
  #get '/scores', to: 'scores#index'


  resources :goals do
    resources :scores
    get 'search', on: :collection, as: :search
    get :favorite, on: :member
  end

  get '/about', to: 'home#about'
  get '/sign_in', to: 'home#debug_sign_in', as: :test_sign_in
  #root 'home#index'
  root 'teams#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
