class Course < ActiveRecord::Base

	serialize :numberings, Hash

	has_and_belongs_to_many :departments
	has_many :components
	has_many :professors, through: :components
	has_many :professors, through: :sections

	validates :williams_id, presence: true

  # Returns the number associated with the primary department
  # OR the number associated with the given department
	def number(dept = nil)
    numberings[(dept || primary_department).abbreviation]
	end

  def primary_department
    departments.first
  end

end