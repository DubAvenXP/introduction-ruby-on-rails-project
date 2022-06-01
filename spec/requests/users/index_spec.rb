require 'rails_helper'
require 'shared_stuff'

RSpec.describe "UsersController", type: :request do
  include_context "shared stuff"

  describe "GET /users" do
    it "works!" do
      get users_path, headers: { 'Authorization' => "Bearer #{ @current_user[:token] }" }
      
      #TODO: refactor to shared
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      
      # Custom specs
      expect(response_body).to be_a(Array)
      expect(response_body.length).to be > 0
      
    end
  end
end
