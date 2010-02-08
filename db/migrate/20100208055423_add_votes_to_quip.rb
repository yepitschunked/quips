class AddVotesToQuip < ActiveRecord::Migration
  def self.up
    add_column :quips, :votes, :integer, :default => 0
  end

  def self.down
    remove_column :quips, :votes
  end
end
