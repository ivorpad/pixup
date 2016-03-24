Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'welcome#index'

  get "projects/:project_id/add_member" => "projects#add_member", :as => "add_member"

  match "projects/:project_id/add_member_to_project" => "projects#add_member_to_project",
        :as => "add_member_to_project",
        :via => [:post, :patch]

  resources :projects, except: [:show, :index] do

  resources :categories, only: :edit

    resources :categories do
      resources :posts do
        resources :comments, module: :posts
      end

      resources :assets do 
        resources :comments, module: :assets
        resource :like, module: :assets
      end

    end

    # TODO Fix this so I can take the category_id param.

    # resources :assets, except: [:show] do
    #     resources :comments, module: :assets
    #     resource :like, module: :assets
    # end

  end

  match "projects/:project_id/categories/:categories_id/:type" => "assets/file_types#show", 
      :as => "assets_content_type", 
      via: :get

  scope path: '/projects', controller: :projects do
    get '' => :index
    get ':project_id' => :show
  end

  scope path: '/projects', controller: :assets do
    get ':project_id/:category_id/:id' => :show
  end
end
