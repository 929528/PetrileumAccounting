PetroleumAccounting::Application.routes.draw do
	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".
	namespace :catalogs do
		resources :employees
		resources :customers do 
			get 'new_contract', on: :collection
			get 'get_contracts', on: :collection
		end
		resources :organizations do 
			get 'new_department', on: :collection
			get 'get_departments', on: :collection 
		end
		resources :products
		resources :promotions
	end
	resources :prices

	namespace :documents do 
		resources :talons_issues do 
			get 'new_issue', on: :collection, to: 'actions/talons/issues#new'
		end
		resources :talons_repaids do 
			get 'new_repaid', on: :collection, to: 'actions/talons/repaids#new'
		end
	end
	# You can have the root of your site routed with "root"
	root 'sessions#new'
	get 'employee_profile', to: 'profiles/employee#show'
	get 'customer_profile', to: 'profiles/customer#show'
	resources :sessions
	match '/signup' => 'sessions#signup', via: [:get, :post]
	match '/reset_password' => 'sessions#reset_password', via: [:get, :post]
	match '/signin' => 'sessions#new', via: :get
	match '/signout' => 'sessions#destroy', via: :delete
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
