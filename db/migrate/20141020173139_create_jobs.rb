class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :level
      t.string :type
      t.string :link

      t.timestamps
    end
  end
end
