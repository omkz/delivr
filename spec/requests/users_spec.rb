require 'rails_helper'

RSpec.describe "Users", type: :request do
  path '/users/{id}/transactions' do

    get 'List all transactions belonging to a user' do
      tags 'Users'
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
        let(:user) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/users/top_total_transaction' do

    get 'The top x users by total transaction amount within a date range' do
      tags 'Users'
      produces 'application/json'
      parameter name: :query, in: :query, schema: {
        type: :object,
        properties: {
          start_date: { type: :string, enum: ['2019-08-26'] },
          end_date: { type: :string, enum: ['2019-08-30'] }
        },
        required: [ 'start_date', 'end_date' ]
      }

      response '404', 'transactions not found' do
        let(:user) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/users/total_by_transactions_above' do

    get 'Total number of users who made transactions above $v within a date range' do
      tags 'Users'
      produces 'application/json'
      parameter name: :query, in: :query, schema: {
        type: :object,
        properties: {
          start_date: { type: :string, enum: ['2019-08-26'] },
          end_date: { type: :string, enum: ['2019-08-30'] },
          amount: { type: :number, enum: ['10'] }
        },
        required: [ 'amount', 'start_date', 'end_date' ]
      }

      response '404', 'transactions not found' do
        let(:user) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/users/total_by_transactions_below' do

    get 'Total number of users who made transactions below $v within a date range' do
      tags 'Users'
      produces 'application/json'
      parameter name: :query, in: :query, schema: {
        type: :object,
        properties: {
          start_date: { type: :string, enum: ['2019-08-26'] },
          end_date: { type: :string, enum: ['2019-08-30'] },
          amount: { type: :number, enum: ['1000'] }
        },
        required: [ 'amount', 'start_date', 'end_date' ]
      }

      response '404', 'transactions not found' do
        let(:user) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/users/near_by' do

    get 'List all restaurants within the vicinity of the user’s location' do
      tags 'Users'
      produces 'application/json'
      parameter name: :user_id, in: :query, schema: {
        type: :object,
        properties: {
          user_id: { type: :number, enum: ['1']}
        },
        required: [ 'user_id']
      }

      response '404', 'restaurants not found' do
        let(:restaurant) { 'invalid' }
        run_test!
      end
    end
  end

end
