Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'welcome#index'

  get "projects/:project_id/add_member" => "projects#add_member", :as => "add_member"
  post "projects/:project_id/add_member_to_project" => "projects#add_member_to_project", :as => "add_member_to_project"

  resources :projects, except: [:show, :index] do
    resources :category, controller: 'categories', as: :category do
        resources :asset, controller: 'assets', as: :assets, only: [:show, :new], path: ''
    end
    resources :category, controller: 'categories', as: :category, only: [:new, :index, :show]
    resources :asset, controller: 'assets', as: :assets, except: [:show] do
        resources :comments, only: [:create, :destroy]
    end
  end

  scope path: '/projects', controller: :projects do
    get '' => :index
    get ':project_id' => :show
  end

  scope path: '/projects', controller: :assets do
    get ':project_id/:category_id/:id' => :show
  end
end
