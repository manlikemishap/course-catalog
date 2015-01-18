class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	# Note it does not reference professor or department because
    	# it is a HABTM relationship

    	# The 6 digit course id in the catalog, like 018650
    	t.string :williams_id, limit: 6

    	t.string :offered
    	t.string :last_offered

    	t.string :title

    	# diversity, writing, quantitative
    	t.boolean :d
    	t.boolean :w
    	t.boolean :q

    	t.text :description, limit: 1000

    	t.string :format, limit: 50

    	# This is REQUIREMENTS + EVALUATION METHODOLOGY
    	t.string :eval

    	# We could serialize and store courses in here too
    	t.string :prereqs

    	t.string :preferences

    	t.integer :enrollment_limit
    	t.integer :expected_enrollment

    	t.string :department_notes
    	t.string :distribution_notes

    	t.string :extra_info
    	t.string :extra_info_2

    	t.string :fees

    	# Serialized. Will likely become its own table
    	t.string :attributes

      t.timestamps null: false
    end
  end
end
