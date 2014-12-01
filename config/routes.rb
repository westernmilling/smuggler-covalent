Rails.application.routes.draw do
  devise_for :users

  get '/entity_typeahead', :as => :entity_typeahead, :to => 'entity_typeahead#index'
  get '/product_typeahead', :as => :product_typeahead, :to => 'product_typeahead#index'
  
  namespace :import do
    resources :batches
  end
  resources :entities
  resources :entity_translations
  resources :product_translations
  resources :products
end
