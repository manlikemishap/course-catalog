Fabricator(:section) do
	semester { ["Spring", "Fall"].sample }
	days { ["TBA", "MTWRF".sample(rand(3))].sample }

end