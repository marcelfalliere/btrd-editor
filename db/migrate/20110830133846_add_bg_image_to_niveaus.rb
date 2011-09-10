class AddBgImageToNiveaus < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :bgImage, :string
  end

  def self.down
    remove_column :niveaus, :bgImage
  end
end
