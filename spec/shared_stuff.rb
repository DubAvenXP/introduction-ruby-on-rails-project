require "jwt"

RSpec.configure do |rspec|
    rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "shared stuff", :shared_context => :metadata do
    # Authentication
    
    before { 
        @user = create(:user)
        @current_user = { 
            id: @user.id,
            name: @user.name,
            email: @user.email,
            role: @user.role,
            token: JWT.encode({
                sub: @user.id, exp: (8.hours.from_now).to_i
            }, Rails.application.secrets.secret_key_base)
        }
    }
    def shared_method
        "it works"
    end
    # let(:user) { create(:user) }
    # let(:@current_user) { user }
    subject do
        'this is the subject'
    end
end

RSpec.configure do |rspec|
rspec.include_context "shared stuff", :include_shared => true
end