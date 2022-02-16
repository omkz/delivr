Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      
      origins ['http://localhost:19006','https://delivr-food.herokuapp.com/menus/lists']
  
      resource '*',
        headers: :any,
        methods: [:get]
    end
  end