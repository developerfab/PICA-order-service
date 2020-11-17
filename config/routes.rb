Rails.application.routes.draw do
  resources :orders, only: [:index, :show, :create, :update] do
    resources :order_products, only: [:index, :create, :destroy]
  end
end
