class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :lessons, dependent: :destroy

  validates :name, presence:true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :email, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum:6}, allow_blank: true

  before_save :downcase_email

  has_secure_password

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes! remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new remember_digest.is_password?(remember_token)
  end

  def forget
    update_attributes! remember_digest: nil
  end

  def authenticated? attribute,token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new digest.is_password? token
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include?(other_user)
  end

  private
  def downcase_email
    self.email = email.downcase
  end 
end
