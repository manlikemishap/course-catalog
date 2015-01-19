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
		d.courses << Fabricate(:course, department: d)
	end
end