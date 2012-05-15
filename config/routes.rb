Klinkr::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :klinks,   only: [:create, :destroy, :show, :index]

  root to: 'static_pages#home'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/help',  to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/browse',to: 'static_pages#browse'
end