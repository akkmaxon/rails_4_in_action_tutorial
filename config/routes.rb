Rails.application.routes.draw do
  root "projects#index"

  namespace :admin do
    root 'application#index'
    resources :projects, only: [:new, :create, :destroy]
    resources :users, except: :destroy do
      member do
	patch :archive
      end
    end
    resources :states, only: [:index, :new, :create] do
      member do
	get :make_default
      end
    end
  end

  namespace :api do
    resources :projects, only: [] do
      resources :tickets
    end
  end

  devise_for :users

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
	get :search
      end
      member do
	post :watch
      end
    end
  end

  resources :tickets, only: [] do
    resources :comments, only: :create
    resources :tags, only: [] do
      member do
	delete :remove
      end
    end
  end

  resources :attachments, only: [:show, :new]
end
