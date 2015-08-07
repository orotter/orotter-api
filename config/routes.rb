Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Routing for API
  namespace 'api' do
    namespace 'v1' do
      get  'u'                => 'users#search'
      get  'u/login'          => 'sessions#login'
      post 'u/login'          => 'sessions#login'
      get  'u/logout'         => 'sessions#logout'
      get  'u/signup'         => 'sessions#signup'
      post 'u/signup'         => 'sessions#signup'
      get  'u/:id/follow'     => 'users#follow'
      get  'u/:id/unfollow'   => 'users#unfollow'
      get  'u/follows'        => 'users#follows'
      get  'u/followers'      => 'users#followers'
      get  't'                => 'tweets#index'
      get  't/create'         => 'tweets#create'
      post 't/create'         => 'tweets#create'
      get  't/:id/favorite'   => 'tweets#favorite'
      get  't/:id/unfavorite' => 'tweets#unfavorite'
    end
  end
  
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
