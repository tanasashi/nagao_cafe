Rails.application.routes.draw do

   devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }


 scope module: :public do
    root to: 'homes#top'
  get 'about' => 'homes#about'

  resources :addresses, except: [:show, :new]

  resources :items, only: [:index, :show]

  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :update, :create, :destroy]

   post 'orders/confirm' => 'orders#confirm'
   get 'orders/thanks' => 'orders#thanks'
  resources :orders, only: [:index, :show, :new, :create]

  #自作customerのroutes
    get 'customers/mypage' => 'customers#show'
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/verify' => 'customers#verify'
    patch 'customers/withdraw' => 'customers#withdraw'

  end

  namespace :admin do

   get '/' => 'admin#top'
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, except: [:destroy]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [:show, :update]
   resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
