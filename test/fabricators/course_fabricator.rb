Fabricator(:course) do 
	# Need attrs. Make it a model
	williams_id 				{ Faker::Code.ean[0..5] }
	last_offered 				{ [nil, ["Spring ", "Fall "].sample + (Time.now.year - 1 - rand(8)).to_s].sample }
	title 							{ Faker::Company.catch_phrase }
	d 									{ ([true] + [false] * 5).sample }
	w 									{ ([true] + [false] * 5).sample }
	q 									{ ([true] + [false] * 5).sample }
	description					{ Faker::Lorem.paragraph }
	format 							{ (["Lecture"]*5 + ["Seminar"]*3 + ["Tutorial"] + ["Studio"]).sample }
	eval								{ Faker::Lorem.sentence }
	# I don't think prereqs is good to do here. It's too complicated. I'll
	# probably do it in seeds.rb
	preferences         { [nil, Faker::Lorem.sentence].sample }
	enrollment_limit		{ [10, 12, 19, 30, 36, 50, nil].sample }
	expected_enrollment { |attrs| attrs[:enrollment_limit].nil? ? nil : attrs[:enrollment_limit] - rand(attrs[:enrollment_limit] / 2) }
	department_notes 		{ [([nil] * 5), Faker::Lorem.sentence].sample }
	distribution_notes	{ [([nil] * 5), Faker::Lorem.sentence].sample }
	extra_info					{ [([nil] * 5), Faker::Lorem.sentence].sample }
	extra_info_2				{ nil }
	fees								{ "bla bla $" + rand(200).to_s }
	#attrs								
end