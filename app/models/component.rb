class Component < ActiveRecord::Base
	belongs_to :course
	has_and_belongs_to_many :professors
		
	validates	:days, :type, presence: true
end