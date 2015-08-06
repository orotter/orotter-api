class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
  has_many :tweets
  has_and_belongs_to_many :follows,
    join_table: :follows,
    class_name: "User",
    foreign_key: "from_user_id",
    association_foreign_key: "to_user_id"
  has_and_belongs_to_many :followers,
    join_table: :follows,
    class_name: "User",
    foreign_key: "to_user_id",
    association_foreign_key: "from_user_id"
      
  def email_required?
    false
  end
  
  def email_changed?
    false
  end

  def follows_count
    self.follows.count
  end
  
  def followers_count
    self.followers.count
  end
  
  def tweets_count
    self.tweets.count
  end

  def as_json(options = { })
    super((options || { }).merge({
        :include => [],
        :methods => [:favorites, :follows_count, :followers_count, :tweets_count]
    }))
  end
end
