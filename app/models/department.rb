class Department < ActiveRecord::Base
	
	has_many :courses
	has_many :professors

	validates :abbreviation, presence: true, length: { maximum: 5 }
	validates :division, presence: true
end
