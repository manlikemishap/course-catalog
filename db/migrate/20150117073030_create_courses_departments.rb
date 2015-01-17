class CreateCoursesDepartments < ActiveRecord::Migration
  def change
    create_table :courses_departments do |t|
    	t.integer :course_id
    	t.integer :department_id
    end
  end
end
