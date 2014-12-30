Rails.application.routes.draw do
  devise_for :users

  root 'import/batches#index'

  get(
    '/entity_typeahead',
    :as => :entity_typeahead,
    :to => 'entity_typeahead#index')
  get(
    '/product_typeahead',
    :as => :product_typeahead,
    :to => 'product_typeahead#index')
  get(
    '/unit_of_measure_typeahead',
    :as => :unit_of_measure_typeahead,
    :to => 'unit_of_measure_typeahead#index')
  put(
    '/import/batch/:id/process',
    :as => :process_import_batch,
    :to => 'import/batch/process#update')

  namespace :import do
    resources :batches
  end
  resources :entities
  resources :entity_translations
  resources :price_translations
  resources :products
  resources :product_translations
  resources :purchase_orders do
    resources(
      :lines,
      :controller => 'purchase_order/lines',
      :only => [:create, :new])
  end
  resources(
    :purchase_order_lines,
    :controller => 'purchase_order/lines',
    :only => [:edit, :destroy, :show, :update])
  resources :quantity_translations
  resources :unit_of_measures
  resources :unit_of_measure_translations
end
