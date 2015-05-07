class Activity < ActiveRecord::Base
  enum action: [:learn, :follow, :unfollow]

  belongs_to :user

  validates :user_id, presence: true
  validates :action, presence: true
  validates :target_id, presence: true

  scope :created_time_sort, -> {order created_at: :desc}

  following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
  scope :feed_activities, ->user { 
    where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: user.id).order(created_at: :desc)
  }

  def target
    learn? ? Lesson.find_by(id: target_id) : User.find_by(id: target_id)
  end
end
