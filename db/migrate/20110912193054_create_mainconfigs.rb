class CreateMainconfigs < ActiveRecord::Migration
  def self.up
    create_table :mainconfigs do |t|
      t.string :root

      t.timestamps
    end
  end

  def self.down
    drop_table :mainconfigs
  end
end
