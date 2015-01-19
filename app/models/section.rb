class Section < ActiveRecord::Base
	validates :days, :semester, presence: true
end