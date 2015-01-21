class Professor < ActiveRecord::Base

	belongs_to :department
	has_and_belongs_to_many :sections

	has_many :courses, through: :sections

	validates :name, presence: true

	def courses
    sections.collect { |s| s.course }
  end
  
end