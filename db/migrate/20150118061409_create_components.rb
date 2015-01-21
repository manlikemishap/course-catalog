class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
    	t.string :type # LAB, CON
    	t.references :course
      t.timestamps null: false
    end
  end
end
