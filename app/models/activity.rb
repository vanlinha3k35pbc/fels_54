class Activity < ActiveRecord::Base
  enum action: [:learn, :follow, :unfollow]

  belongs_to :user

  scope :sort, -> { order created_at: :desc }
end
