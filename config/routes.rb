Rails.application.routes.draw do
  root 'home#index'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'consent/:token', to: 'parental_consents#new', as: 'parental_consent'
  post 'consent/:token', to: 'parental_consents#create'

  # Organizations
  resources :organizations do
    resources :memberships, only: [:index, :create, :update, :destroy, :edit]
    
    resources :spaces do
      post 'join', on: :member
    end
    
    resources :reports, only: [:index, :show] do
      post 'generate', on: :collection
    end
    
    get 'dashboard', to: 'organizations#dashboard'
  end

  get 'dashboard', to: 'dashboard#index'
end
