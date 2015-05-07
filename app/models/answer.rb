class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :results, dependent: :destroy

  validates :content, presence: true

  scope :right_answers_amount, ->lesson {
    joins(:results).where("results.lesson_id = ?", lesson.id).where(correct: true).count
  }
end
