class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :category_id, presence: true
  validates :content, presence: true
  validate :atleast_one_is_checked

  learned_word_ids = "SELECT word_id FROM results JOIN lessons ON results.lesson_id = lessons.id" 
  learned_word_ids << " WHERE (lessons.user_id = :user_id AND answer_id IS NOT NULL)"
  scope :learned_words, ->user {where "id IN (#{learned_word_ids})", 
    user_id: user.id}

  scope :not_learned_words, ->user {where "id NOT IN (#{learned_word_ids})",
    user_id: user.id}

  scope :find_word_by_category, ->category_id {where category_id: category_id if category_id}

  scope :random_words, ->user {not_learned_words(user).limit(20)
    .order "RANDOM()"}

  def atleast_one_is_checked
    if answers.select{|answer| answer.correct}.blank?
      errors.add :base, "You have to choose a correct answer of word"
    end
  end
end
