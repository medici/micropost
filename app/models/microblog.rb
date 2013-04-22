class Microblog < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microblogs.created_at DESC'

  scope :including_replies, lambda { |microblog_id| where(in_reply_to: microblog_id) }

  def replying?
    !self.in_reply_to.nil?
  end

 #def replied?
 #  !Microblog.including_replies(self.id).empty?
 #end

  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
  	                     WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
