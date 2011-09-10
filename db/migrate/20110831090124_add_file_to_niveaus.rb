class AddFileToNiveaus < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :file, :string
  end

  def self.down
    remove_column :niveaus, :file
  end
end
