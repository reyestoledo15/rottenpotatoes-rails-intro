class Movie < ActiveRecord::Base
    
    def self.movies(filter,sort_t)
        return self.order(sort_t) if not filter
        self.where(:rating => filter.keys).order(sort_t)
    end
    
    def self.all_ratings
        self.pluck(:rating).uniq
    end
end