class CreateDepartments < ActiveRecord::Migration
	def change
		create_table :departments do |t|
			t.integer :division
			t.string :name
			t.string :abbrev
			
			t.timestamps null: false
		end
	end
end
