
Rails.application.routes.draw do

  namespace :me do
  get 'message_responses/show'
  end

  class FormatTest
    attr_accessor :mime_type

    def initialize(format)
      @mime_type = Mime::Type.lookup_by_extension(format)
    end

    def matches?(request)
      request.format == mime_type
    end
  end

  #API for angular
  resources :messages
  
  resources :posts

  # mount Monologue::Engine, at: '/blog' # or whatever path, be it "/blog" or "/monologue"

  get 'search', to: 'search#index', as: :search
  get 'auto_complete', to: 'me#autocomplete', as: :autocomplete

  devise_for :users, :controllers => {registrations: 'registration', sessions: 'sessions'}
 # get 'me/*path' => 'angular#index'
 devise_scope :user do
  
   get '/alpha', :to => "landing#index"
   post 'landing/index', :to => "landing#add_email"
   get 'registration/selection', :to => "registration#selection", :as => :selection
 
  resources :businesses do
    resources :messages, :controller => :business_messages
  end

  resources :entities
  
  namespace :me do
    get '/send_data' => 'messages#send_data'
    resources :following
    resources :followers
    # resources :messages
    resources :sent_messages
    resources :received_messages
    resources :message_responses
  end

  resources :users do
    resources :messages, :controller => :user_messages
  end
  resources :emails
  # devise_for :users, :controllers => {registrations: 'landing'}

  root to: 'temporary#index'

  resource :admin,:controller => :admin, :module => :admin do 
    resources :users, :only => [:index, :show, :destroy]
    resources :businesses,  :only => [:index, :show, :destroy]
    resources :emails, :only => [:index, :show, :destroy]
    resources :posts, :only => [:index, :show, :destroy]
    resources :responses, :only => [:index, :show, :destroy], :controller => :posts
    resources :messages, :only => [:index, :show, :destroy], :controller => :posts

  end
  # get 'me', :to => "user_profile#index", :as => :user_profile
  get '/me', :to => 'me/users#index'

  namespace :me do

    resources :posts
    resources :business_connections
    resources :connections
  end

  # resources :users
  resource :me, :controller => :users, :module => :me do
    # resources :messages, :controller => :messages

    resources :photos, :controller => :user_photos
    resources :messages, only: [:index, :create]

    # resources :posts, :type => "UserPost"
    resources :posts, :controller => :user_posts
    resources :responses
    resources :feed, :controller => :news_feed
    # resources :feed, :controller => :news_feed, :constraints => FormatTest.new(:json)
    # resources :feed, :to => "ember#index", :constraints => FormatTest.new(:html)

    # resources :audience, :constraints => FormatTest.new(:json)
    # resources :audience, :to => "ember#index", :constraints => FormatTest.new(:html)
    resources :audience
    resources :connections 
    resources :friendships
    resources :ownerships 

    resources :business_connections
    resources :businesses do
      # resources :business_posts
      resources :posts, :controller => :business_posts
      # resources :messages

      resources :photos, :controller => :business_photos
    end
  end

  if Rails.env.production?
    match '*a', :to => 'errors#routing', via: :get
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
