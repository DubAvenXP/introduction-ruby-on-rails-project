class User < ApplicationRecord
    enum roles: [:super_administrator, :team_member]

    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :name, presence: true, length: { maximum: 50 }
    validates :password_digest, presence: true, length: { minimum: 6 }
    validates :role, presence: true, inclusion: { in: roles.keys }
    
end
