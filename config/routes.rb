Rails.application.routes.draw do

  devise_for :users

  resources :setlists do
    get 'edit_items' => 'setlists#edit_items'
    get 'add_items' => 'setlists#add_items'
    post 'items' => 'setlists#create_item'
    post 'rearrange_items' => 'setlists#rearrange_items'
    post 'change_item_key' => 'setlists#change_item_key'
    delete 'items' => 'setlists#destroy_item'
  end

  resources :songs
  get 'print_song/:id' => 'songs#print_song'

  get 'about'    => 'static#about'
  get 'admin'    => 'admin#index'
  get 'home'     => 'users#home'
  get 'profile'  => 'users#profile'
  get 'settings' => 'users#settings'
  patch 'settings' => 'users#update'

  get 'help' => 'help#index'
  get 'help/songdown_syntax' => 'help#songdown_syntax'

  post 'admin/reassign_role' => 'admin#reassign_role'
  get 'admin/reset_statistics' => 'admin#reset_statistics'

  post 'api/search_songs' => 'api#search_songs'
  post 'api/compile_songdown' => 'api#compile_songdown'
  post 'api/transpose_song' => 'api#transpose_song'

  root 'users#home'
end
