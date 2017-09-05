# frozen_string_literal: true
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  # Home page
  root 'home#index'

  # Login
  get '/auth/:provider/callback', to: 'session#create'
  get '/auth/failure', to: 'session#auth_failure'
  get 'signout', to: 'session#destroy', as: 'signout'
  get 'login', to: 'session#login', as: 'login'

  # Users
  get 'users/typeahead', to: 'profile#typeahead'
  get 'users/', to: 'profile#index', as: 'users'
  get 'users/:id', to: 'profile#show', as: 'user'
  get 'users/:id/all_posts', to: 'profile#all_posts', as: 'all_posts'

  get 'profile/delete'

  get 'tags/:tag', to: 'profile#show', as: :tag

  # User /me area
  namespace :me do
    get '/', to: 'profiles#edit', as: 'edit_user'
    resources :pages
    resources :ownership_requests, only: [:create, :new, :index]
    post '/ownership_requests/:id/accept', to: 'ownership_requests#accept', as: 'accept_ownership_request'
    post '/ownership_requests/:id/reject', to: 'ownership_requests#reject', as: 'reject_ownership_request'    
    resource :profile, only: [:edit, :update]
  end

  # Pages
  get 'pages', to: 'pages#index', defaults: {name_only: true, format: :json}
  get 'communities', to: 'pages#index', defaults: {kind: :community}
  get 'communities/:id', to: 'pages#show', defaults: {kind: :community}, as: 'community'
  get 'companies', to: 'pages#index', defaults: {kind: :company}
  get 'companies/:id', to: 'pages#show', defaults: {kind: :company}, as: 'company'  
  get 'communities/typeahead', to: 'pages#typeahead', defaults: {kind: :community}
  get 'companies/typeahead', to: 'pages#typeahead', defaults: {kind: :company}

  # Events
  get 'events', to: 'events#index', defaults: { format: 'html' }
  get 'events/typeahead', to: 'events#typeahead'
  get 'events/locations', to: 'events#locations', defaults: { format: 'json' }
  get 'events/sources', to: 'events#sources'
  get 'events/all_events', to: 'events#all_events', defaults: { format: 'json' }
  get 'events/range_events(/query/:query)', to: 'events#range_events'

  # Opendata
  get 'opendata', to: 'home#opendata'

  # Admin
  get 'admin', to: 'admin#index'
  put 'admin/make_page_active', to: 'admin#make_page_active'
  put 'admin/make_page_inactive', to: 'admin#make_page_inactive'
  delete 'admin/delete_page', to: 'admin#delete_page'
  put 'admin/make_post_active', to: 'admin#make_post_active'
  put 'admin/make_post_inactive', to: 'admin#make_post_inactive'
  put 'admin/make_post_job', to: 'admin#make_post_job'
  put 'admin/make_post_unjob', to: 'admin#make_post_unjob'
  put 'admin/ban_user', to: 'admin#ban_user'
  put 'admin/unban_user', to: 'admin#unban_user'

  # Feed
  get 'feed', to: 'feed#index', as: 'feed'
  get 'feed/data', to: 'feed#data', defaults: { format: 'json' }
  get 'feed/posts', to: 'feed#posts'
  get 'feed/sources', to: 'feed#sources'
  get 'feed/count_by_month', to: 'feed#count_by_month'
  
  resources :wikipages, path: 'wiki'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
