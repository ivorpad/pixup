# == Route Map
#
#                   Prefix Verb   URI Pattern                                    Controller#Action
#         new_user_session GET    /users/sign_in(.:format)                       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                      devise/sessions#destroy
#            user_password POST   /users/password(.:format)                      devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                  devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                 devise/passwords#edit
#                          PATCH  /users/password(.:format)                      devise/passwords#update
#                          PUT    /users/password(.:format)                      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                        devise/registrations#cancel
#        user_registration POST   /users(.:format)                               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                          devise/registrations#edit
#                          PATCH  /users(.:format)                               devise/registrations#update
#                          PUT    /users(.:format)                               devise/registrations#update
#                          DELETE /users(.:format)                               devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)                  devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)              devise/confirmations#new
#                          GET    /users/confirmation(.:format)                  devise/confirmations#show
#                     root GET    /                                              welcome#index
#           project_assets GET    /projects/:project_id/asset(.:format)          assets#index
#                          POST   /projects/:project_id/asset(.:format)          assets#create
#        new_project_asset GET    /projects/:project_id/asset/new(.:format)      assets#new
#       edit_project_asset GET    /projects/:project_id/asset/:id/edit(.:format) assets#edit
#            project_asset GET    /projects/:project_id/asset/:id(.:format)      assets#show
#                          PATCH  /projects/:project_id/asset/:id(.:format)      assets#update
#                          PUT    /projects/:project_id/asset/:id(.:format)      assets#update
#                          DELETE /projects/:project_id/asset/:id(.:format)      assets#destroy
#                 projects GET    /projects(.:format)                            projects#index
#                          POST   /projects(.:format)                            projects#create
#              new_project GET    /projects/new(.:format)                        projects#new
#             edit_project GET    /projects/:id/edit(.:format)                   projects#edit
#                  project GET    /projects/:id(.:format)                        projects#show
#                          PATCH  /projects/:id(.:format)                        projects#update
#                          PUT    /projects/:id(.:format)                        projects#update
#                          DELETE /projects/:id(.:format)                        projects#destroy
#

Rails.application.routes.draw do



  devise_for :users
  root to: 'welcome#index'

  # http://stackoverflow.com/questions/14731654/no-route-matches-action-show-controller-users
  # TODO: Not sure about this approach 
  resources :projects do
    resources :category, controller: 'categories', as: :category
    resources :asset, controller: 'assets', as: :assets
  end
end

# localhost.com/projects/:project_id/asset/:id
