class AddTierToNiveaus < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :tier, :integer
  end

  def self.down
    remove_column :niveaus, :tier
  end
end
