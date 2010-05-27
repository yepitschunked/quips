class Quip < ActiveRecord::Base
    cattr_reader :per_page
    @@per_page = 15
end
