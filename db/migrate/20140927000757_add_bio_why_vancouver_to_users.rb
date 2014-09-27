class AddBioWhyVancouverToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :why_vancouver, :string
  end
end
