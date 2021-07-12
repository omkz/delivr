Rails.application.routes.draw do
  apipie
  resources :restaurants, only: [] do
    collection do
      get 'search_by_dishes'
      get 'search_by_dishes_price_range'
      get 'most_popular'
      get 'transactions'
      get 'near_by'
      get 'search'
      get 'open_at'
      get 'opening_hours_per_day'
      get 'opening_hours_per_week'
    end
  end

  resources :users, only: [] do
    collection do
      get 'top_total_transaction'
      get 'total_by_transactions_above'
      get 'total_by_transactions_below'
      get 'transactions'
      get 'near_by'
    end
  end

  resources :purchases, only: [:create, :show]

end
