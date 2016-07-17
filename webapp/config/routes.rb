Rails.application.routes.draw do

  get 'home/index'
  get 'home/data', to: 'home#data', defaults: { format: 'json' }
  get 'home/posts(/query/:query)', to: 'home#posts'

  # User routing
  get 'me', to: 'profile#edit', as: 'edit_user'
  get 'users/typeahead(/query/:query)', to:'profile#typeahead'
  get 'users(/query/:query)', to: 'profile#index', as: 'users'
  get 'users/:id', to: 'profile#show', as: 'user'
  get 'profile/delete'
  get 'me/new', to: 'profile#new', as: 'new_user'
  post 'me', to: 'profile#create', as: 'create_user'
  patch 'users/:id', to: 'profile#update', as: 'update_user'

  get 'communities/typeahead', to:'communities#typeahead'
  get 'companies/typeahead', to:'companies#typeahead'

  resources :pages, path: '/me/pages'
  resources :communities
  resources :companies

  get 'events', to: 'events#index', defaults: { format: 'html' }
  get 'events/typeahead', to:'events#typeahead'

  get 'opendata', to: 'opendata#index'

  get 'admin', to: 'admin#index'
  get 'admin/page_state(/query/:query)', to: 'admin#page_state', defaults: { format: 'json' }

  # get 'me/pages/new', to: 'pages#new', as: 'new_page'
  # get 'me/pages', to: 'pages#my_pages', as: 'pages'
  # post 'me/pages/', to: 'pages#create'
  # get 'me/pages/:id', to: 'pages#edit', as: 'edit_page'
  # delete '/me/pages/:id', to: 'pages#destroy', as: 'delete_page'
  #
  # put 'pages/:id', to: 'pages#update'
  # patch 'pages/:id', to: 'pages#update'
  #
  # get 'companies/', to: 'companies#index', as: 'companies'
  # get 'companies/:id', to: 'companies#show', as: 'company'
  # put 'companies/:id', to: 'pages#update'
  # patch 'companies/:id', to: 'pages#update'

  # get 'communities/', to: 'communities#index', as: 'communities'
  # get 'communities/:id', to: 'communities#show', as: 'community'
  # put 'communities/:id', to: 'pages#update'
  # patch 'communities/:id', to: 'pages#update'

  get '/auth/:provider/callback', to: 'session#create'
  get '/auth/failure', to: 'session#auth_failure'
  get 'signout', to: 'session#destroy', as: 'signout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
