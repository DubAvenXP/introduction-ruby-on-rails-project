class User < ApplicationRecord
    include ActiveModel::SecurePassword
    
    has_secure_password
    
    has_many :comments, dependent: :destroy
    has_many :assignments, dependent: :destroy

    # TODO: add different validations for POST and PUT
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :name, presence: true, length: { maximum: 50 }
    validates :role, presence: true, inclusion: { in: %w(super_administrator team_member) }
end
