Rails.application.routes.draw do

  devise_for :users

  resources :setlists do
    post 'search_songs' => 'setlists#search_songs'
    get 'add_song' => 'setlists#add_song'
    get 'update_song' => 'setlists#update_song'
    delete 'songs' => 'setlists#destroy_song'
  end

  resources :songs
  get 'print_song/:id' => 'songs#print_song'

  get 'about'    => 'static#about'
  get 'home'     => 'users#home'
  get 'profile'  => 'users#profile'
  get 'settings' => 'users#settings'
  patch 'settings' => 'users#update'

  get 'help' => 'help#index'
  get 'help/songdown_syntax' => 'help#songdown_syntax'

  post 'api/transpose_song' => 'api#transpose_song'

  root 'users#home'
end
