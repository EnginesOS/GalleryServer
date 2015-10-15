Rails.application.routes.draw do

  devise_for :users

  # admin registrations via console or admin panel.
  devise_for :admins, :skip => [:registrations]

  # recreate the edit routes that were lost by skipping registrations
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', :as => 'admin_registration'
  end

  # 'my home' routes
  get 'user_home', :to => 'user_homes#show', :as => :user_root
  get 'admin_home', :to => 'admin_homes#show', :as => :admin_root

  # admin actions
  resources :user_admins do
    member do
      get :ban, :unban
    end
  end

  root 'homes#show', :format => 'html'
  resource :home

  resource :info_pages do
    get :overview, :install, :screenshots, :technical_brief,
          :software_videos, :credits, :contact, :about, :social_buttons
  end
  resources :published_softwares do
    member do
      get :add_tag, :remove_tag
    end
  end
  resources :comments
  resources :tags do
    collection do
      get :tag_cloud
    end
  end

  get 'install', to: 'info_pages#install_curl_script'
  get 'api/v0/software', to: 'published_softwares#index', :format => 'json'
  get 'api/v0/software_tags', to: 'tags#list_tags_by_name', :format => 'json'
  get 'published_softwares/:id/edit_icon', to: "published_softwares#edit_icon", as: :edit_blueprint_info_icon
  get 'published_softwares/:id/refresh_blueprint_info', to: "published_softwares#refresh_blueprint_info", as: :refresh_blueprint_info_published_software
  get 'published_softwares/:id/refresh_icon_from_blueprint', to: "published_softwares#refresh_icon_from_blueprint", as: :refresh_published_software_icon_from_blueprint_info
  mount RailsAdmin::Engine => '/admin', as: 'db_admin'
end
