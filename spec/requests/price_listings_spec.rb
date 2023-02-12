require 'rails_helper'

RSpec.describe "PriceListings", type: :request do
  describe "GET /pricing" do
    it "returns http success" do
      get "/price_listings/pricing"
      expect(response).to have_http_status(:success)
    end
  end
end
