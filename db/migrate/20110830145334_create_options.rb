class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.references :element
      t.string :name
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
