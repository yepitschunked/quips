class AddDeltaToQuips < ActiveRecord::Migration
  def change
    add_column :quips, :delta, :boolean, default: true, null: false
  end
end
