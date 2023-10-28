require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users" do
    it "returns http success" do
      get "/pages/users"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin" do
    it "returns http success" do
      get "/pages/admin"
      expect(response).to have_http_status(:success)
    end
  end

end
