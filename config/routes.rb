Rails.application.routes.draw do
  resources :restaurants, only: [] do
    collection do
      get 'search_by_dishes'
    end
  end
end
