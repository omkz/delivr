Rails.application.routes.draw do
  resources :restaurants, only: [] do
    collection do
      get 'search_by_dishes'
      get 'search_by_dishes_price_range'
      get 'most_popular'
      get 'transactions'
      get 'near_by'
      get 'search'
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

end
