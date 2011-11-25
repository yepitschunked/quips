class ChangeQuipToText < ActiveRecord::Migration
  def up
    change_table :quips do |t|
      t.change :quip, :text
    end
  end

  def down
    change_table :quips do |t|
      t.change :quip, :string
    end
  end
end
