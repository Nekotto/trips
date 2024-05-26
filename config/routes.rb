Rails.application.routes.draw do
  scope module: :public do
    root to: "articles#index"
    devise_for :users
    devise_for :admin, skip: [:registrations, :password], controllers: {
      sessions: 'admin/sessions'
    }
   
    resources :articles, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :index, :edit, :update]
    
  end
  
    namespace :admin do
      get 'dashboards', to: 'dashboards#index'
      resources :users, only: [:destroy]
    end
  
end