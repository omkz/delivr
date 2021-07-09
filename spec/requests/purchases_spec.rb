require 'rails_helper'

RSpec.describe "Purchases", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/purchases/create"
      expect(response).to have_http_status(:success)
    end
  end

end
