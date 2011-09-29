class AddIsReallyDeletedToNiveaus < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :isReallyDeleted, :boolean
  end

  def self.down
    remove_column :niveaus, :isReallyDeleted
  end
end
