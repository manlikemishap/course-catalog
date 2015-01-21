class Section < ActiveRecord::Base

 	validates :component_id, :days, :semester, presence: true

	has_and_belongs_to_many :professors
	belongs_to :component, dependent: :destroy

	def course
		component.course
	end
end