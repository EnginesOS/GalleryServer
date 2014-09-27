Rails.application.routes.draw do
  resources :published_softwares      do
    get :detailslist, :on => :collection
  end

        resources :published_softwares, :path => "json_published_softwares", :only => [:index,:show,:detailslist ], :defaults => { :format => 'json' }
  
 
  root 'published_softwares#index'
end
