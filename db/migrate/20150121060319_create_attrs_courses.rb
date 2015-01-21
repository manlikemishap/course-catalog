class CreateAttrsCourses < ActiveRecord::Migration
  def change
    create_table :attrs_courses do |t|
      t.integer :attr_id
      t.integer :course_id
    end
  end
end
