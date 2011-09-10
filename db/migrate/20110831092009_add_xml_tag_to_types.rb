class AddXmlTagToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :xmlTag, :string
  end

  def self.down
    remove_column :types, :xmlTag
  end
end
