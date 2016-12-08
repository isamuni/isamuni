Rails.application.routes.draw do
    mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
    # Home page
    get 'home/index'
    root 'home#index'

    # User routing
    get 'me', to: 'profile#edit', as: 'edit_user'
    get 'login', to: 'session#login', as: 'login'

    get 'users/typeahead(/query/:query)', to: 'profile#typeahead'
    get 'users(/query/:query)', to: 'profile#index', as: 'users'
    get 'users/:id', to: 'profile#show', as: 'user'
    get 'users/:id/all_posts', to: 'profile#all_posts', as: 'all_posts'
    get 'profile/delete'

    get 'tags/:tag', to: 'profile#show', as: :tag

    # get 'me/new', to: 'profile#new', as: 'new_user'
    # post 'me', to: 'profile#create', as: 'create_user'

    patch 'users/:id', to: 'profile#update', as: 'update_user'

    get 'communities/typeahead', to: 'communities#typeahead'
    get 'companies/typeahead', to: 'companies#typeahead'

    put 'me/pages/request_ownership', to: 'pages#request_ownership'
    get 'pages', to: 'pages#index_all_names'
    post 'pages', to: 'pages#create'
    resources :pages, path: '/me/pages'

    resources :communities
    resources :companies

    # Events
    get 'events', to: 'events#index', defaults: { format: 'html' }
    get 'events/typeahead', to: 'events#typeahead'
    get 'events/locations', to: 'events#locations', defaults: { format: 'json' }
    get 'events/sources', to: 'events#sources'
    get 'events/all_events', to: 'events#all_events', defaults: { format: 'json' }
    get 'events/range_events(/query/:query)', to: 'events#range_events'

    # Opendata
    get 'opendata', to: 'opendata#index'

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

    # Feed
    get 'feed', to: 'feed#index', as: 'feed'
    get 'feed/data', to: 'feed#data', defaults: { format: 'json' }
    get 'feed/posts', to: 'feed#posts'
    get 'feed/sources', to: 'feed#sources'

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
