class CreateProfessorsSections < ActiveRecord::Migration
  def change
    create_table :professors_sections do |t|
    	t.integer :professor_id
    	t.integer :section_id    	
    end
  end
end