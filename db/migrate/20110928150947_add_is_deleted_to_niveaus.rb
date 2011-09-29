class AddIsDeletedToNiveaus < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :isDeleted, :boole
  end

  def self.down
    remove_column :niveaus, :isDeleted
  end
end
