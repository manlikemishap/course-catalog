class Professor < ActiveRecord::Base

	belongs_to :department
	has_and_belongs_to_many :sections
	has_and_belongs_to_many :components	

	validates :name, presence: true
end