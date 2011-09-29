class AddIsSegmentToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :isSegment, :boolean
  end

  def self.down
    remove_column :types, :isSegment
  end
end
