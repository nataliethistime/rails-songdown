Rails.application.routes.draw do

  resources :setlists do
    get 'edit_items' => 'setlists#edit_items'
    get 'add_items' => 'setlists#add_items'
    post 'items' => 'setlists#create_item'
    post 'rearrange_items' => 'setlists#rearrange_items'
    post 'change_item_key' => 'setlists#change_item_key'
    delete 'items' => 'setlists#destroy_item'
  end

  resources :songs

  get 'about'    => 'static#about'
  get 'admin'    => 'admin#index'
  get 'home'     => 'users#home'
  get 'logout'   => 'sessions#destroy'
  get 'profile'  => 'users#profile'
  get 'register' => 'lobby#register'
  get 'settings' => 'users#settings'

  get 'help' => 'help#index'
  get 'help/faq' => 'help#faq'
  get 'help/songdown_syntax' => 'help#songdown_syntax'

  post 'login' => 'sessions#create'
  post 'register'   => 'users#create'

  post 'admin/reassign_role' => 'admin#reassign_role'
  get 'admin/reset_statistics' => 'admin#reset_statistics'

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
