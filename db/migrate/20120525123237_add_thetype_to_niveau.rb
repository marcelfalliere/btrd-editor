class AddThetypeToNiveau < ActiveRecord::Migration
  def self.up
    add_column :niveaus, :thetype, :string
  end

  def self.down
    remove_column :niveaus, :thetype
  end
end
