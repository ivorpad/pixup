Rails.application.routes.draw do

  get 'assets/index'

  get 'assets/new'

  get 'assets/create'

  get 'assets/show'

  get 'assets/edit'

  get 'assets/update'

  get 'assets/destroy'

  devise_for :users
  root to: 'welcome#index'

  resources :projects
end
