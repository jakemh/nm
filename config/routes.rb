Rails.application.routes.draw do

  namespace :admin do
  get 'emails/index'
  end

  namespace :admin do
  get 'emails/show'
  end

  mount Judge::Engine => '/judge'
  resource :business
  resources :emails
  # devise_for :users, :controllers => {registrations: 'landing'}
  devise_for :users, :controllers => {registrations: 'registration', sessions: 'sessions'}

  root to: 'temporary#index'

  devise_scope :user do
    
    get '/alpha', :to => "landing#index"
    post 'landing/index', :to => "landing#add_email"
    get 'registration/selection', :to => "registration#selection", :as => :selection
  

  resource :admin,:controller => :admin, :module => :admin do 
    resources :users, :only => [:index, :show, :destroy]
    resources :businesses,  :only => [:index, :show, :destroy]
    resources :emails, :only => [:index, :show, :destroy]
  end
  # get 'me', :to => "user_profile#index", :as => :user_profile
  namespace :me do
    resources :posts
  end

  resources :users
  resource :me, :controller => :users, :module => :me do
    resources :posts, :type => "UserPost"
    resources :connections 
    resources :businesses do
      resources :business_posts
      resources :photos, :controller => :business_photos
    end
    resources :friendships
  end
  end
  # root :to => "landing#index"
  # post 'landing/index', :to => "landing#create"

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
