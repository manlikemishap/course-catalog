class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|

    	t.references :course

    	t.string :semester, limit: 20

    	# This particular bit will need to be more robust later. Perhaps a serialized 
    	# custom time class
    	t.string :days

      t.timestamps null: false
    end
  end
end
