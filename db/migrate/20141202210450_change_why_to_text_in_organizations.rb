class ChangeWhyToTextInOrganizations < ActiveRecord::Migration
  def change
    change_column :organizations, :why_vancouver, :text
  end
end
