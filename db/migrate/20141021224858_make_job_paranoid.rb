class MakeJobParanoid < ActiveRecord::Migration
  def self.up
    add_column :jobs, :deleted_at, :datetime
  end

  def self.down
    remove_column :jobs, :deleted_at
  end
end
