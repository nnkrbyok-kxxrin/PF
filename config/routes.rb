Rails.application.routes.draw do

  # devise_for :adminsをゲストログイン機能実装により、以下に変更
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  root to: 'homes#top'

  # ゲストログイン機能実装
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#guest_sign_in'
  end

  # get 'search/search'
  # 上記のデフォルトの記述を以下に変更
  get '/search' => 'search#search'
  get '/about' => 'homes#about'
  get '/info' => 'homes#info'

  resources :tasks, only:[:create, :destroy]
  resources :events, only:[:index, :show, :create, :update, :destroy]

  resources :guests do
    resources :posts, only:[:create, :destroy]
    resource :bookmarks, only:[:create, :destroy]
  end

end