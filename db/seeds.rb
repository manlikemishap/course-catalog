# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

departments = JSON.parse(File.read("#{Rails.root}/departments.json"))
departments.each do |dept|
	Department.create!(name:     			 dept["name"],
										 abbreviation:   dept["abbrev"],
										 division:       1 + rand(3) )
end

# Create some professors
Department.all.each do |dept|
	5.times do 
		dept.professors << Fabricate(:professor, department: dept)
	end
end

# Remember that these are independent of professors
# Create non-cross-listed courses
Department.all.each do |dept|
	10.times do 
		dept.courses << Fabricate(:course, numberings: { dept.abbreviation => 101 + rand(398) })
	end
end

# Crosslisted with n depts
(2..4).each do |n|
	# Create n-crosslisted courses
	10.times do |i|
		depts = Department.all.sample(n)
		course = Fabricate.build(:course)
		depts.each do |dept|
			dept.courses << course
			course.numberings[dept.abbreviation] = 101 + rand(398)
			course.save
		end
	end
end	

# Give some courses components
Course.all.sample(Course.count / 4).each do |course|
	comp = Fabricate([:conference, :lab].sample)
	course.components << comp	
	Professor.all.sample.components << comp	
	# 10% chance of another prof also owning this component
	if rand(100) > 90
		Professor.all.sample.components << comp	
	end
end

# Give all courses sections, some more than others
Course.all.each do |course|
	([1] * 10 + [2] * 3 + [3] * 2).sample.times do 
		section = Fabricate(:section, course: course)
		([1] * 5 + [2]).sample.times do 
			Professor.all.sample.sections << section
		end
	end
end