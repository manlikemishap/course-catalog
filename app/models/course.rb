class Course < ActiveRecord::Base

	serialize :numberings, Hash

	has_and_belongs_to_many :departments
	has_many :components

	validates :williams_id, presence: true

	def number

	end
end