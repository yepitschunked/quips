class AddQuipColumn < ActiveRecord::Migration
  def self.up
      add_column :quips, :quip, :string
  end

  def self.down
      remove_column :quips, :quip
  end
end
