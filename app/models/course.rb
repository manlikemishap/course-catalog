class Course < ActiveRecord::Base

	serialize :numberings, Hash

	has_and_belongs_to_many :departments
	has_many :components
	has_many :professors, through: :components
	has_many :professors, through: :sections

	validates :williams_id, presence: true

	def number

	end
end