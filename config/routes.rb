Rails.application.routes.draw do

  namespace :api do
    resources :articles, only: [:index, :new, :create, :update]
      get "/articles/:id/highlights" => "articles#show_article_highlights"
      get "/articles/:id/topics" => "articles#get_article_topics"
      get "/articles/:id" => "articles#show"

    resources :users , only: [:index,:new,:create,:update,:show]
      get "/users/:id/highlights" => "users#get_user_highlights"
      get "/users/:id/collections" => "users#get_user_collections"
      get "/users/:id/topics" => "users#get_user_topics"
    resources :sessions, only: [:create, :destroy]
    resources :highlights, only: [:create,:show]
    get "/highlights/:id/topics" => "highlights#get_highlight_topics"

    resources :collections, only: [:create, :destroy, :update, :show]
    get "/collections/:id/highlights" => "collections#get_collection_highlights"

    post "/topics" => "topics#create_topics"
    get "/topics/:id" => "topics#show"
    get "/topics/:id/users" => "topics#get_users"
    get "/topics" => "topics#search"


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
