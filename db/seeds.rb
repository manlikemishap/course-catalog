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

# Remember that these are independent of professors
# Create non-cross-listed courses
Department.all.each do |d|
	10.times do 
		d.courses << Fabricate(:course)
	end
end

# Crosslisted with n depts
(2..4).each do |n|
	# Create n-crosslisted courses
	10.times do |i|
		depts = Department.all.sample(n)
		c = Fabricate.build(:course)#, departments: depts)
		depts.each do |d|
			d.courses << c
			c.numberings[d.abbreviation] = 101 + rand(398)
			c.save
		end
	end
end	

# Create some professors
Department.all.each do |d|
	5.times do 
		d.professors << Fabricate(:professor, department: d)
	end
end