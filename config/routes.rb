Rails.application.routes.draw do

  devise_for :admins

  root to: "homes#top"

  # get 'search/search'
  # 上記のデフォルトの記述を以下に変更
  get "/search" => "search#search"

  resources :tasks, only:[:create, :destroy]

  resources :posts do
    resources :add_infomations, only:[:create, :destroy]
    resource :bookmarks, only:[:create, :destroy]
  end

end