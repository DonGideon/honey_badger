class User < ActiveRecord::Base
	validates :name,  presence: true, uniqueness: true
	has_many :searches
	has_many :tweets, through: :searches
end
