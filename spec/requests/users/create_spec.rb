require 'rails_helper'
require 'shared_stuff'

RSpec.describe "UsersController", type: :request do
  include_context "shared stuff"

  describe "POST /users" do
    it "creates a user" do
      post '/users', headers: { 'Authorization' => "Bearer #{ @current_user[:token] }" }, params: { 
          user: {
            name: "Lionel Messi",
            email: "messi@lomax.com.gt",
            password: "123456Abc$%",
            password_confirmation: "123456Abc$%",
            role: "super_administrator"
          }
        }

      #puts params
      puts response.body
      
      #TODO: refactor to shared
      # request_body = JSON.parse(request.body)
      # response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      # puts "request ..."
      # puts request_body
      # # # Custom specs
      # expect(response_body).to be_a(Hash)

      # expect(response_body).to have_key("id")
      # expect(response_body["id"]).to be_a(Integer)
      # expect(response_body["id"]).to be > 0

      # expect(response_body).to have_key("name")
      # expect(response_body["name"]).to be_a(String)
      # expect(response_body["name"]).to be_present
      
      # expect(response_body).to have_key("role")
      # expect(response_body["role"]).to be_in(["super_administrator", "team_member"])
      # expect(response_body["role"]).to be_present
      
      # expect(response_body).to have_key("email")
      # expect(response_body["email"]).to be_a(String)
      # expect(response_body["email"]).to be_present
      # expect(response_body["email"]).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)

      # expect(response_body).to have_key("status")
      # expect(response_body["status"]).to be_present
      # expect(response_body["status"]).to be_in([true, false])
    end
  end
end
