Rails.application.routes.draw do
  resources :orders do
    resources :pizzas
  end
end
