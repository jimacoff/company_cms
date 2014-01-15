Website::Application.routes.draw do

  # Locele param in app
  scope '(:locale)', locale: /en|vi/ do
    # Admin path
    scope module: 'admin', path: 'boss' do
      # Main admin path
      get '/' => 'sessions#new', as: :boss
      # Session routes
      resources :sessions, only: [:new, :create, :destroy]
      get 'login' => 'sessions#new'
      delete 'logout' => 'sessions#destroy'

      # Account path
      get 'account' => 'users#edit'
      patch 'account' => 'users#update'

      # Service path
      resources :services

      # Team member path
      resources :team_members

      # Work path
      resources :works do
        resources :images, only: [:new, :create]
      end

      # Images path
      resources :images, only: [:destroy]

      # Message path
      resources :messages, only: [:index, :destroy]

      # Post path
      resources :posts
      post '/posts/uploadImage' => 'posts#upload_image', as: :post_image
    end

    # Font page
    scope module: 'front', as: 'front' do
      resources :messages
    end


    # Root path
    root 'static_pages#home'
    # Root path for locale include path
    get '/:locale' => 'static_pages#home'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
