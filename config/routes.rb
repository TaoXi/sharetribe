ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.                                                                                                                        

  map.resource :session
  map.resources :favors, :collection => { :search => :get }                            
  map.resources :listings, :collection => { :search => :get } do |listing|
    listing.resource :image
    listing.resources :listing_comments 
    listing.resources :categories, :path_prefix => '/listings'
  end  
  map.resources :people, :member => { :home => :get }, :collection => { :search => :get } do |person|
    person.resources :inbox, :controller => :messages
    person.resource :purse
    person.resource :settings
    person.resources :friends
    person.resources :contacts
    person.resources :listings, :collection => { 
      :interesting => :get, 
      :mark_as_interesting => :post, 
      :remove_from_interesting => :delete 
    } do |listing|
    end  
    # person.resources :interesting, :controller => :interesting_listings, :path_prefix => '/people/:person_id/listings'
    #     person.resource :own, :controller => :listings, :path_prefix => '/people/:person_id/listings'
  end  
  map.resources :items, :collection => { :search => :get }
  map.resource :search
  
  map.root :controller => "people", :action => "home"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
