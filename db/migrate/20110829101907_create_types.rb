class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :types
  end
end
