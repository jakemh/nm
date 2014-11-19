
Rails.application.routes.draw do


  get 'flags/index'

  get 'flags/show'

  get 'flags/new'

  get 'flags/create'

  get 'flags/edit'

  get 'flags/update'

  get 'tags/index'

  get 'skills/index'

  class Format
    attr_accessor :mime_type

    def initialize(format)
      @mime_type = Mime::Type.lookup_by_extension(format)
    end

    def matches?(request)
      request.format == mime_type
    end
  end

  devise_scope :user do
    get '/alpha', :to => "landing#index"
    post 'landing/index', :to => "landing#add_email"
    get 'registration/selection', :to => "registration#selection", :as => :selection
  end

  constraints(Format.new(:html)) do
    get '/me/audience/', :to => 'angular#index'
    get '/businesses/', :to => 'angular#index'
    get '/users/', :to => 'angular#index'
    get '/messages/', :to => 'angular#index'
    get '/businesses/*all', :to => 'angular#index'

    constraints(id: /\d+/) do
      get '/users/:id', :to => 'angular#index'
    end

    get '/me/feed', :to => 'angular#index'
    get '/me/messages', :to => 'angular#index'
  end



  namespace :me do
    get 'message_responses/show'
  end

  #API for angular
  resources :messages
  resources :posts

  # mount Monologue::Engine, at: '/blog' # or whatever path, be it "/blog" or "/monologue"

  get 'search', to: 'search#index', as: :search
  get 'auto_complete', to: 'me#autocomplete', as: :autocomplete

  devise_for :users, :controllers => {registrations: 'registration', sessions: 'sessions'}
  # get 'me/*path' => 'angular#index'

  resources :entities

  namespace :me do
    get '/send_data' => 'messages#send_data'
    resources :following
    # resources :followers
    resources :sent_messages
    resources :received_messages
    resources :message_responses
  end

  resources :businesses do
    resources :tags
  end

  resources :users do
    resources :skills
    resources :businesses, :controller => :user_businesses
  end

  resources :users, :businesses do
    resources :messages
    resources :flags
    resources :sent_messages, :received_messages do
      resources :message_responses
    end


    resources :posts
    resources :followers
    resources :following
  end

  resources :emails

  root to: 'temporary#index'

  resource :admin,:controller => :admin, :module => :admin do
    resources :users, :only => [:index, :show, :destroy]
    resources :businesses,  :only => [:index, :show, :destroy]
    resources :emails, :only => [:index, :show, :destroy]
    resources :posts, :only => [:index, :show, :destroy]
    resources :responses, :only => [:index, :show, :destroy], :controller => :posts
    resources :messages, :only => [:index, :show, :destroy], :controller => :posts

  end
  get '/me', :to => 'me/users#index'

  namespace :me do

    resources :posts
    resources :business_connections
    resources :connections
  end

  # resources :users
  resource :me, :controller => :users, :module => :me do
    resources :photos, :controller => :user_photos
    resources :messages, only: [:index, :create]
    resources :posts, :controller => :user_posts
    resources :responses
    resources :feed, :controller => :news_feed
    resources :audience
    resources :connections
    resources :friendships
    resources :ownerships

    resources :business_connections

    resources :businesses do
      resources :posts, :controller => :business_posts
      resources :photos, :controller => :business_photos
    end

  end

  if Rails.env.production?
    match '*a', :to => 'errors#routing', via: :get
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
