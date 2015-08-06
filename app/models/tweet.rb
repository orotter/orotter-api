class Tweet < ActiveRecord::Base
    belongs_to :user
    has_reputation :favorites, source: :user, aggregated_by: :sum
    
    def favorites
        self.reputation_for(:favorites).to_i
    end
  
    def add_favorite_by(user)
        self.add_or_update_evaluation(:favorites, 1, user)
    end
      
    def delete_favorite_by(user)
        self.delete_evaluation(:favorites, user)
    end
  
    def as_json(options = { })
        super((options || { }).merge({
            :include => [:user],
            :methods => [:favorites]
        }))
    end
end
