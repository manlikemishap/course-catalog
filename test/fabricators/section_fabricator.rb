Fabricator(:section) do
	semester	 	 { ["Spring", "Fall"].sample }
	days 	   		 { JSON.parse(File.read("#{Rails.root}/times.json")).sample.values.join(" ") }
end