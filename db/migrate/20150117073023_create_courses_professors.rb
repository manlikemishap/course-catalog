class CreateCoursesProfessors < ActiveRecord::Migration
  def change
    create_table :courses_professors do |t|
    	t.integer :course_id
    	t.integer :professor_id
    end
  end
end
