require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/restaurants/index"
      expect(response).to have_http_status(:success)
    end
  end

end
