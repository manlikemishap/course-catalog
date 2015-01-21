class Course < ActiveRecord::Base

	serialize :numberings, Hash

  has_and_belongs_to_many :attrs
	has_and_belongs_to_many :departments

	has_many :components
  has_many :sections
  
	has_many :professors, through: :components
	has_many :professors, through: :sections

	validates :williams_id, presence: true

  searchable do
    text :title
    text :departments do
      departments.collect { |d| "#{d.name} #{d.abbreviation}" }.join(" ")
      #{}"#{department.name} #{department.abbreviation}"
    end
    text :professors do
      professors.collect { |p| p.name }.join(" ")
    end
    text :description
    text :attrs

    text :preferences
    text :distribution_notes
    text :department_notes
    text :extra_info
    text :extra_info_2
    text :format
  end

  # Returns the number associated with the primary department
  # OR the number associated with the given department
	def number(dept = nil)
    numberings[(dept || primary_department).abbreviation]
	end

  def primary_department
    departments.first
  end

end