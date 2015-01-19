class CreateComponentsProfessors < ActiveRecord::Migration
  def change
    create_table :components_professors do |t|
    	t.integer :component_id
    	t.integer :professor_id
    end
  end
end
