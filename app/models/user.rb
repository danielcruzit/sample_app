class User < ApplicationRecord

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true
    validates :phone_number, presence: true 
    has_secure_password

    validates :password, presence: true, length: { minimum: 6 }
    #validate is as costume verification 
    validate :check_pwd_confirmation 

    def username 
        name + " | " + email    
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
     end


    private
    def check_pwd_confirmation 
        if password.nil?
            true
        elsif password != password_confirmation
            errors.add(:password_confirmation,"Passwords must match !!") 
        end
    end


end
