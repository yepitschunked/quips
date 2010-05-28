class Quip < ActiveRecord::Base
    cattr_reader :per_page, :sortable_columns, :sort_directions
    @@per_page = 25
    @@sortable_columns = ["votes", "date", "id"]
    @@sort_directions = ["asc", "desc"]

    validates_presence_of :quip
    
end
