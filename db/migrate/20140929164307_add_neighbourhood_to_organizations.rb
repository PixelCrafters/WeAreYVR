class AddNeighbourhoodToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :neighbourhood, :string
  end
end
