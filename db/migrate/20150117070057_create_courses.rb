class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	# Note it does not reference professor because HABTM

        t.references :department
        t.references :primary_department

    	# The 6 digit course id in the catalog, like 018650
    	t.string :williams_id, limit: 6

    	t.string :last_offered

    	t.string :title

        # The catalog data itself needs to be more robust for us to support
        # courses with multiple divisions, so I'm leaving it like this
        t.integer :division

        t.string :numberings

    	# diversity, writing, quantitative
    	t.boolean :d
    	t.boolean :w
    	t.boolean :q

    	t.text :description
        t.text :short_description
        t.string :teaser

    	t.string :format

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
        # Also has to be called attrs because attributes is special
    	t.string :attrs

      t.timestamps null: false
    end
  end
end
