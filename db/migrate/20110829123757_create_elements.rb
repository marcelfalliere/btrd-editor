class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.references :type
      t.references :niveau
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end

  def self.down
    drop_table :elements
  end
end
