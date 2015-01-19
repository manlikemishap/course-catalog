class Section < ActiveRecord::Base
	validates :days, :semester, presence: true
	has_and_belongs_to_many :professors
end