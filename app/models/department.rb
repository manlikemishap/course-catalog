class Department < ActiveRecord::Base
	
	has_and_belongs_to_many :courses
	has_many :professors

	validates :abbreviation, presence: true, length: { maximum: 5 }
	validates :division, presence: true
end
