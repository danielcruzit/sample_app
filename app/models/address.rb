class Address < ApplicationRecord
    
    has_many :users
    validates :address, :zip_code, :city , :country, presence: true
    

end
