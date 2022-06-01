require 'rails_helper'
require 'shared_stuff'

RSpec.describe "UsersController", type: :request do
  include_context "shared stuff"

  describe "GET /users/:id" do
    it "is expected to hashed user" do
      get "/users/#{@current_user[:id]}", headers: { 'Authorization' => "Bearer #{ @current_user[:token] }" }
      
      #TODO: refactor to shared
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      
      # # Custom specs
      expect(response_body).to be_a(Hash)

      expect(response_body).to have_key("id")
      expect(response_body["id"]).to be_a(Integer)
      expect(response_body["id"]).to be > 0

      expect(response_body).to have_key("name")
      expect(response_body["name"]).to be_a(String)
      expect(response_body["name"]).to be_present
      
      expect(response_body).to have_key("role")
      expect(response_body["role"]).to be_in(["super_administrator", "team_member"])
      expect(response_body["role"]).to be_present
      
      expect(response_body).to have_key("email")
      expect(response_body["email"]).to be_a(String)
      expect(response_body["email"]).to be_present
      expect(response_body["email"]).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)

      expect(response_body).to have_key("status")
      expect(response_body["status"]).to be_present
      expect(response_body["status"]).to be_in([true, false])
    end
  end
end
