class Quip < ActiveRecord::Base
  cattr_reader :per_page, :sortable_columns, :sort_directions
  @@per_page = 25
  @@sortable_columns = ["votes", "date", "id"]
  @@sort_directions = ["asc", "desc"]

  validates_presence_of :quip

  define_index do
    indexes quip, :prefixes => true
    set_property :min_prefix_len => 2
    set_property delta: true
  end
  def as_json(options = {})
    if options[:type] == :autocomplete 
      # excerpts comes from sphinx - if it's autocomplete, this method
      # should be injected as we used sphinx to find this object
      {:label => excerpts.quip, :value => id}
    end
  end
end
