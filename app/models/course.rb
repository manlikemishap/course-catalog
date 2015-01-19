class Course < ActiveRecord::Base

	belongs_to :department
	has_many :components

	validates :department_id, :williams_id, presence: true
end