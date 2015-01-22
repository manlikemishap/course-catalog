class Component < ActiveRecord::Base
	belongs_to :course, dependent: :destroy
	has_and_belongs_to_many :professors
	has_many :sections

	validates :course_id, presence: true
end