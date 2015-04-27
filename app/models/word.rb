class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers
  has_many :learned_words, dependent: :destroy

  learned_word_ids = "SELECT word_id FROM learned_words WHERE user_id = :user_id"
  scope :learned_words, ->user {where "id IN (#{learned_word_ids})",
    user_id: user.id}

  scope :not_learned_words, ->user {where "id NOT IN (#{learned_word_ids})",
    user_id: user.id}
end
