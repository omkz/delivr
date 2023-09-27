require 'rails_helper'

RSpec.describe "Purchases", type: :request do

  path '/purchases' do

    post 'Creates a purchase' do
      tags 'Purchases', 'Users'
      consumes 'application/json'
      parameter name: :purchase, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :number, enum: ['1'] },
          restaurant_id: { type: :number, enum: ['1'] },
          menu_id: { type: :number, enum: ['1'] }
        },
        required: [ 'user_id', 'restaurant_id', 'menu_id' ]
      }

      response '201', 'purchase created' do
        let(:purchase) { { user_id: 1, restaurant_id: 1, menu_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:purchase) { { user_id: 'foo' } }
        run_test!
      end
    end
  end

end
