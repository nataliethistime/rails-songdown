Rails.application.routes.draw do

  resources :setlists do
    resources :setlist_items
  end
  resources :songs

  get 'about'    => 'lobby#about'
  get 'admin'    => 'admin#index'
  get 'home'     => 'users#home'
  get 'login'    => 'sessions#new'
  get 'logout'   => 'sessions#destroy'
  get 'profile'  => 'users#profile'
  get 'register' => 'users#new'
  get 'settings' => 'users#setting'

  post 'attempt_login' => 'sessions#create'
  post 'create_user'   => 'users#create'
  post 'admin/reassign_role' => 'admin#reassign_role'

  post 'api/search_songs' => 'api#search_songs'

  root 'lobby#index'

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
