class AddPerfVoisinToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :perfVoisin, :boolean
  end

  def self.down
    remove_column :types, :perfVoisin
  end
end
