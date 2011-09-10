class CreateNiveaus < ActiveRecord::Migration
  def self.up
    create_table :niveaus do |t|
      t.integer :numero
      t.string :titre

      t.timestamps
    end
  end

  def self.down
    drop_table :niveaus
  end
end
