class Quip < ActiveRecord::Base
  cattr_reader :per_page, :sortable_columns, :sort_directions
  @@per_page = 25
  @@sortable_columns = ["votes", "date", "id"]
  @@sort_directions = ["asc", "desc"]

  include Tire::Model::Search
  include Tire::Model::Callbacks

  validates_presence_of :quip

  def as_json(options = {})
    if options[:type] == :autocomplete 
      {:label => quip, :value => id}
    end
  end
end
