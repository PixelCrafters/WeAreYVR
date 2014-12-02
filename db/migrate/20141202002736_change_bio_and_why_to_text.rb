class ChangeBioAndWhyToText < ActiveRecord::Migration
  def change
    change_column :users, :bio, :text
    change_column :users, :why_vancouver, :text
  end
end
