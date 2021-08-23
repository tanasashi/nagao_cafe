Rails.application.routes.draw do
  root to: 'homes#top'
  get 'about' => 'homes#about'

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


  namespace :admin do
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, except: [:destroy]
   resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
