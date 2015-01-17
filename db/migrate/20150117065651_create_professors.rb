class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
    	t.references :department
    	t.string :name
      t.timestamps null: false
    end
  end
end
