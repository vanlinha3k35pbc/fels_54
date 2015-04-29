class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers

  validates :category_id, presence: true
  validates :content, presence: true
  validate :atleast_one_is_checked

  learned_word_ids = "SELECT word_id FROM learned_words WHERE user_id = :user_id"
  scope :learned_words, ->user {where "id IN (#{learned_word_ids})",
    user_id: user.id}

  scope :not_learned_words, ->user {where "id NOT IN (#{learned_word_ids})",
    user_id: user.id}

  def atleast_one_is_checked
    if answers.select{|answer| answer.correct}.blank?
      errors.add(:base, "You have to choose a correct option")
    end
  end
end
