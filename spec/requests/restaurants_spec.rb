require 'swagger_helper'

RSpec.describe 'restaurants', type: :request do

  path '/restaurants/search' do

    get 'Searching for restaurants or dishes by name' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :query, in: :query, schema: {
        type: :object,
        properties: {
          query: { type: :string, enum: ['hungry']}
        },
        required: [ 'query' ]
      }

      response '201', 'restaurant created' do
        let(:restaurant) { { name: 'Foo' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:restaurant) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/restaurants/search_by_dishes' do

    get 'Search for restaurants that has a dish matching search term' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :query, in: :query, type: :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            query: { type: :string}
          },
          required: [ 'query' ]
      end

      response '404', 'dish not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end

  path '/restaurants/search_by_dishes_price_range' do

    get 'List all restaurants that have x-z number of dishes within a price range' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :price, in: :query, schema: {
        type: :object,
        properties: {
          min: { type: :number },
          max: { type: :number }
        },
        required: [ 'min', 'max' ]
      }

      response '404', 'dish not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end

  path '/restaurants/near_by' do

    get 'Get restaurant by any location' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :location, in: :query, schema: {
        type: :object,
        properties: {
          location: { type: :string, enum: ['bali']}
        },
        required: [ 'location' ]
      }

      response '404', 'restaurants not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end

  path '/restaurants/opening_hours_per_day' do

    get 'List all restaurants that are open for x-z hours per day"' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :hours, in: :query, schema: {
        type: :object,
        properties: {
          hours_x: { type: :number },
          hours_z: { type: :number }
        },
        required: [ 'hours_x', 'hours_z' ]
      }

      response '404', 'restaurants not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end

  path '/restaurants/opening_hours_per_week' do

    get 'List all restaurants that are open for x-z hours per week' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :hours, in: :query, schema: {
        type: :object,
        properties: {
          hours_x: { type: :number },
          hours_z: { type: :number }
        },
        required: [ 'x_hours', 'z_hours' ]
      }

      response '404', 'restaurants not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end


  path '/restaurants/open_at' do

    get 'List all restaurants that are open at a certain time' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :hours, in: :query, schema: {
        type: :object,
        properties: {
          time: { type: :string, enum: ['09:00'] }
        },
        required: [ 'open_at' ]
      }

      response '404', 'restaurants not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end


  path '/restaurants/most_popular' do

    get 'The most popular restaurants by transaction volume' do
      tags 'Restaurants'
      produces 'application/json'

      response '200', 'restaurants found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            total_amount: { type: :number, format: :decimal },
            total_transactions: { type: :integer }
          },
          required: [ 'id', 'name' ]
      end

    end

  path '/restaurants/{id}/transactions' do

    get 'List all transactions belonging to a restaurant' do
      tags 'Restaurants'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'transactions found' do
        schema type: :object,
          properties: {
            id: { type: :integer }
          },
          required: [ 'id' ]
      end

      response '404', 'transactions not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end
end
