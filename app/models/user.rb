class User < ActiveRecord::Base
	validates :name,  presence: true, uniqueness: true
	has_many :searches
	has_many :tweets, through: :searches

	def serches_history
		self.searches.inject([]){|arr, search| h = {}; h[:created_at] = search.created_at; h[:tweets] = search.tweets.first(10); arr << h; arr}
	end
end
