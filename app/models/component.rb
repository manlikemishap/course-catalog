class Component < ActiveRecord::Base
	belongs_to :course

	validates	:days, :type, presence: true
end