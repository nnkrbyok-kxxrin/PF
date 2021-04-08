Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :admins
  
  # ゲストログイン機能実装
  post '/guest_sign_in' => 'admins#guest_sign_in'
  
  get '/search' => 'search#search'
  get '/about' => 'homes#about'
  get '/info' => 'homes#info'

  resources :admins, only:[:edit, :update]
  resources :tasks, only:[:create, :destroy]
  resources :events, only:[:index, :show, :create, :update, :destroy]

  resources :guests do
    resources :posts, only:[:create, :edit, :update, :destroy]
    resource :bookmarks, only:[:create, :destroy]
  end

end