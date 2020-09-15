class Movie < ActiveRecord::Base
    
    def self.movies(filter,sort_t)
        return self.order(sort_t) if not filter
        self.where(:rating => filter).order(sort_t)
    end
    
    def self.all_ratings
        self.pluck(:rating).uniq
    end
    
    def self.selected(params,session)
        options = {}
        
        options[:ratings] = if params[:ratings]
        if params[:ratings].kind_of? Hash
            params[:ratings].keys
        else
            params[:ratings]
        end
        
        elsif session[:ratings]
            session[:ratings]
        else
            self.all_ratings
        end
        
        options[:sort] = if params[:sort]
            params[:sort]
        elsif session[:sort]
            session[:sort]
        else
            nil
        end
            
        options
    end
          
    
end