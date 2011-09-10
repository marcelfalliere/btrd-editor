class AddCssClassToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :cssClass, :string
  end

  def self.down
    remove_column :types, :cssClass
  end
end
