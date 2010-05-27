class Quip < ActiveRecord::Base
    cattr_reader :per_page, :sortable_columns, :sort_directions
    @@per_page = 15
    @@sortable_columns = ["votes", "date", "id"]
    @@sort_directions = ["asc", "desc"]
    
end
