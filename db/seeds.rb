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

Department.all.each do |d|
	5.times do 
		d.professors << Fabricate(:professor, department: d)
	end

	20.times do 
		profs = Professor.all.sample(([1]*10 + [2]*2 + [1]).sample)
		c = Fabricate(:course, professors: profs, department: d)
		profs.each do |p|
			p.courses << c
		end
	end
end