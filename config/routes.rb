Rails.application.routes.draw do

  get 'nrql/query' => 'nrql#query'
  post 'nrql/insert' => 'nrql#insert'

  resources :queries do
    member do
      get :results
      get :run

      get :edit_javascript_source
      post :update_javascript_source

      get :edit_query
      patch :update_query

      get :gc
    end
  end

  root 'queries#index'

end
