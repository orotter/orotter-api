class Tweet < ActiveRecord::Base
    belongs_to :user
    has_reputation :favorites, source: :user, aggregated_by: :sum
    
    def favorites
        self.reputation_for(:favorites).to_i
    end
  
    def as_json(options = { })
        super((options || { }).merge({
            :include => [:user],
            :methods => [:favorites]
        }))
    end
end
