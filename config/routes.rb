GrammarBrushstrokes::Application.routes.draw do
  root :to => 'grammar_pages#home'

  resources :categories, only: [:show]
  
  match '/active', to: 'grammar_pages#active', via: 'get'
  match '/activesubmit', to: 'grammar_pages#activesubmit', via: 'get'
  match '/activereview', to: 'grammar_pages#activereview', via: 'get'
  match '/participles', to: 'grammar_pages#participles', via: 'get'
  match '/absolutes', to: 'grammar_pages#absolutes', via: 'get'
  match '/appositives', to: 'grammar_pages#appositives', via: 'get'
  match '/adjectives', to: 'grammar_pages#adjectives', via: 'get'
  
  resources :users do
    post :login, on: :collection, as: :login
  end
  
  # Sessions
  get 'log_in' => 'sessions#new', :as => 'log_in'
  post 'validate_user' => 'sessions#create', :as => 'validate_user'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'

  # match '/login', to: 'session#login', via: 'get'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
