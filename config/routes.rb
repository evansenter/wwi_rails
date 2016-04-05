Rails.application.routes.draw do
  devise_for :users, has_one: :contact_info

  devise_scope :user do
    get    "register", to: "devise/registrations#new"
    get    "login",    to: "devise/sessions#new"
    delete "logout",   to: "devise/sessions#destroy"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root "welcome#index"
  root "welcome#landing"

  # Example of regular route:
  #   get "products/:id" => "catalog#view"
  # get "documents"    => "uploads#index"
  get "manage" => "admin#manage_site"

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get "products/:id/purchase" => "catalog#purchase", as: :purchase
  get "set_role/:user_id/:role" => "admin#set_user_role", as: "set_user_role"
  get "set_status/:upload_id/:status" => "admin#set_upload_status", as: "set_article_status"

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :articles, only: [:index, :new, :create, :destroy], controller: "uploads"
  resources :posts

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get "short"
  #       post "toggle"
  #     end
  #
  #     collection do
  #       get "sold"
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
  #       get "recent", on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post "toggle"
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
