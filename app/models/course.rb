class Course < ActiveRecord::Base

	belongs_to :department
	has_and_belongs_to_many :professors
	has_many :components

	validates :department_id, :williams_id, presence: true
end