require 'csv'

departments = JSON.parse(File.read("#{Rails.root}/departments.json"))
departments.each do |dept|
	Department.create!(name:     			 dept["name"],
										 abbreviation:   dept["abbrev"],
										 division:       1 + rand(3) )
end

CSV.foreach("catalog1415.csv", headers: true) do |row|
  next if row["Offered"] && row["Offered"].start_with?("Not")
  next if row["Term Sort"].blank?

  course = Course.find_by(williams_id: row["Course ID"])
  if course.nil? && !row["Offered"].blank?
    # The first time this ID appears, it's a course. It SHOULD always be one anyway first 
    course = Course.create!(williams_id:         row["Course ID"],
                            title:               row["Course Title"],
                            division:            row["Division"].split(" ")[1],
                            d:                  !row["(D)"].blank?,
                            q:                  !row["(Q)"].blank?,
                            w:                  !row["(W)"].blank?,
                            description:         row["Course Descr"],
                            format:              row["Cls Format"],
                            eval:                row["Rqmt/Eval"],
                            prereqs:             row["Prereqs"],
                            enrollment_limit:    row["Enrl Limit"],
                            expected_enrollment: row["Exp Cls Sz"],
                            preferences:         row["Preferences"],
                            department_notes:    row["Dept Notes"],
                            distribution_notes:  row["Distrib Notes"],
                            extra_info:          row["Extra Info"],
                            extra_info_2:        row["Extra Info2"],
                            fees:                row["Matl/Lab Fee"],
                            attrs:               (1..10).collect { |i| Attr.where(name: row["Attribute#{i}"]).first_or_create }
                            )
  end

  if Department.find_by(abbreviation: row["Subject Sort"]).nil?
    puts row
    exit
  end

  if course.nil?
    puts row
    puts "\nHERE\n"
    puts row["Course ID"]
    puts row["Subject Sort"]    
  end

  # This is additional info grabbed every time we see it
  dept = Department.where(abbreviation: row["Subject Sort"]).first_or_create

  if !dept.courses.include?(course)
    if row["Primary/Secondary"] == "Primary"
      # Primary course to front for crosslists (explicit primary)
      #course.departments.unshift(dept)
      course.primary_department_id = dept.id
    end
    #else
      # This also covers non-crosslisted courses
      course.departments.append(dept)
    #end
  end

  # Hash subject => number
  course.numberings[row["Subject Sort"]] = row["Catalog Nbr"].strip if row["Catalog Nbr"]
  course.save!

  # Create component if one of this type doesn't exist for the course

  componentType =  {"SEM" => Seminar,
                    "LEC" => Lecture,
                    "STU" => Studio,
                    "HON" => Honor,
                    "TUT" => Tutorial,
                    "LAB" => Lab,
                    "IND" => IndependentStudy,
                    "CON" => Conference,
                    "LSN" => Studio }[row["Component"]]

  if !course.components.map { |c| c.type == componentType.to_s }.any?

    course.components << (component = componentType.create!(course: course))

    # Push section to component
    component.sections << Section.create!(days:       (1..3).map { |i| row["Pat#{i}"].nil? ? nil : row["Pat#{i}"] + " " + row["Start Time#{i}"].to_s + (row["Start Time#{i}"].nil? ? "" : "-") + row["End Time#{i}"].to_s }.compact.join(","),
                                          semester:   row["Offered"].nil? ? course.sections.last.semester : row["Offered"].split(" ")[0],
                                          section:    row["Term Sort"] == "1151" ? "Fall" : "Spring",
                                          professors: (1..6).map { |i| row["Last Name #{i}"].nil? ? nil : row["First Name #{i}"] + " " + row["Last Name #{i}"] }.compact.map { |name| Professor.where(name: name).first_or_create },
                                          component: component                                         
                                          )
  end
  
end


=begin
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
=end