class AddIsTestToNiveaus < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :isTest, :boolean
  end

  def self.down
    remove_column :niveaus, :isTest
  end
end
