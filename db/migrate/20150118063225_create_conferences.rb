class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|

      t.timestamps null: false
    end
  end
end
