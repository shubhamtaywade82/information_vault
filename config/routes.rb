Rails.application.routes.draw do
  # Sets the root route to login form
  root 'vault_items#index'
  # creates resourceful routes here except the new and create
  resources :users, except: %i[new create]
  # sets the routes for registrations controller Signup form for new and create actions
  resources :registrations, controller: 'users/registrations', only: %i[new create]
  # sets the routes for sessions controller login form for the new, create and destroy actions
  resources :sessions, controller: 'users/sessions', only: %i[new create destroy]
  # get confirmation
  resources :confirmations, controller: 'users/confirmations', only: :show

  resources :vault_items, except: :show do
    resources :accesses, controller: 'vault_items/accesses'
    member do
      get :verify
      post :verify_user
    end
  end
end
