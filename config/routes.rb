Rails.application.routes.draw do


 # get 'welcome/index'
  root 'welcome#index'
  post 'trainer/:id', to: 'trainer#review', as: :trainer
  get 'trainers/', to: 'trainer#index', as: :trainers

  # Example of regular route:
  #  get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :cards
  resources :users, only: [:show, :edit, :update]
  get '/registration', to: 'registrations#new'
  post '/registrations', to: 'registrations#create'

  resources :sessions, only: [:new, :create, :destroy]
  get '/sign_in', to: 'sessions#new', as: :sign_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out


  get 'oauths/oauth'
  get 'oauths/callback'

  post "/oauth/callback" => "oauths#callback"
  get "/oauth/callback" => "oauths#callback"
  get "/oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
