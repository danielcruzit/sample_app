class User < ApplicationRecord

    #has many 1-n relationship 
    #dependent destroy means if deleted user, his micro posts go too
    belongs_to :address
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy    
    has_many :following, through: :active_relationships, source: :followed 
    has_many :followers, through: :passive_relationships, source: :follower

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    before_save { email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
                      
    validates :phone_number, presence: true 
    has_secure_password

    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    #validate is as costume verification 
    validate :check_pwd_confirmation 

    def feed
        microposts
    end

    def username 
        name + " | " + email    
    end
    #start to follow some one
    def follow(other_user)
        following << other_user
    end
    #stop follow some one
    def unfollow(other_user)
        following.delete(other_user)
    end

    # Returns true if the current user is following the other user.
    def following?(other_user)
        following.include?(other_user)
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
     end

    def city_address
        if address.nil?
         "Sem abrigo :(("
        else
         address.city 
        end
    end


    # Returns true if a password reset has expired. 
    def password_reset_expired?
        reset_sent_at < 2.hours.ago 
    end

    # Returns a user's status feed.
    def feed
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
      end


    private
    def check_pwd_confirmation 
        if password.nil?
            true
        elsif password != password_confirmation
            errors.add(:password_confirmation,"Passwords must match !!") 
        end
    end

    def logged_in_user
        unless logged_in?
           flash[:danger] = "Please log in."
           redirect_to login_url
       end
    end

end
