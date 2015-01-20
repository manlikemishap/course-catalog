class Professor < ActiveRecord::Base

	belongs_to :department
	has_and_belongs_to_many :sections
	has_and_belongs_to_many :components	

	has_many :courses, through: :components
	has_many :courses, through: :sections

	validates :name, presence: true
end