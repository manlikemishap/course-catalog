# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

departments = JSON.parse(File.read("#{Rails.root}/departments.json"))
departments.each do |d|
	Department.create!(name:     			 d["name"],
										 abbreviation:   d["abbrev"],
										 division:       1 + rand(3) )
end

# Create courses. Remember that these are independent of professors
Department.all.each do |d|
	5.times do 
		d.courses << Fabricate(:course, department: d)
	end
end

# Create some professors
Department.all.each do |d|
	5.times do 
		d.professors << Fabricate(:professor, department: d)
	end
end

# For each professor, assign them a section of a course in their department
# There is some chance that the multiple profs will be assigned the same course
Professor.all.each do |p|
	c = p.department.courses.sample
	c.components << Fabricate([:conference, :lab].sample)
	c.sections << 
end