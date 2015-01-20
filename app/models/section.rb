class Section < ActiveRecord::Base
	validates :days, :semester, presence: true
	has_and_belongs_to_many :professors
	belongs_to :course
end