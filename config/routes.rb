Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#welcome'

  resources :merchants, only: [:show, :create] do
     resources :invoices, only: [:index, :show]
     resources :items
     resources :dashboard, only: [:index]
   end

   namespace :admin do
     resources :invoices
     resources :merchants
     resources :dashboard, only: [:index]
   end

   resources :admin, only: [:index]

end
