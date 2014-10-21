class AddDefaultValueToSponsoredInJob < ActiveRecord::Migration
  def change
    change_column :jobs, :sponsored, :boolean, :default => false
  end
end
