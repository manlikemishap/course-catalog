class Course < ActiveRecord::Base

	serialize :numberings, Hash

  has_and_belongs_to_many :attrs
	has_and_belongs_to_many :departments

	has_many :components
  has_many :sections, through: :components
	has_many :professors, through: :sections

	validates :williams_id, presence: true

  searchable do
    # Scoping
    integer :division, multiple: true
    string :semesters, multiple: true
    #boolean :distributions, multiple: true
    boolean :w
    boolean :q
    boolean :d

    # Text searches
    text :title, boost: 4.0
    text :departments, boost: 6.0 do
      departments.collect { |d| "#{d.name} #{d.abbreviation}" }.join(" ")
      #{}"#{department.name} #{department.abbreviation}"
    end
    text :professors do
      professors.collect { |p| p.name }.join(" ")
    end
    text :description
    text :attrs do

    end

    text :preferences
    text :distribution_notes
    text :department_notes
    text :extra_info
    text :extra_info_2
    text :format
  end

  def xlistings
    departments.map { |dept| "#{dept.abbreviation} #{number(dept)}" }
  end

  def crosslistings
    xlistings
  end

  def distributions
    # ew
    [:q, :w, :d].map { |dist| self[dist] == true ? dist : nil }.compact
  end

  def semesters
    sections.map { |s| s.semester }.to_set.to_a
  end

  def self.where_semester(semester)
    Course.all.map { |course| course.sections.map { |s| s.semester == semester}.any? ? course : nil }.compact
  end

  def self.spring
    Course.where_semester("Spring")    
  end

  def self.fall
    Course.where_semester("Fall")
  end

  def spring?
    sections.map { |s| s.semester == "Spring" }.any?
  end

  def fall?
    sections.map { |s| s.semester == "Fall" }.any?    
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