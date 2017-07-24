Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post, :delete], :controllers => { :registrations => "registrations" }
  #resources :goals
  resources :teams do
    post 'import_okrs', on: :member
    #get 'import_okrs', on: :member
  end
  resources :goals
  get '/about', to: 'home#about'
  #root 'home#index'
  root 'teams#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
