Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  resources :published_softwares
  resources :comments
  resources :tags
  resources :published_softwares, :path => "json_published_softwares", :only => [:index,:show], :defaults => { :format => 'json' }
  root 'pages#home'
  get 'published_softwares/:id/edit_icon', to: "published_softwares#edit_icon", as: :edit_blueprint_info_icon
  get 'published_softwares/:id/refresh_blueprint_info', to: "published_softwares#refresh_blueprint_info", as: :refresh_blueprint_info_published_software
  get 'published_softwares/:id/refresh_icon_from_blueprint', to: "published_softwares#refresh_icon_from_blueprint", as: :refresh_published_software_icon_from_blueprint_info
end
