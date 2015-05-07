class Result < ActiveRecord::Base
  belongs_to :word
  belongs_to :lesson
  belongs_to :answer

  scope :done_words_amount, ->lesson {
    where("answer_id IS NOT NULL AND lesson_id = ?", lesson.id).count}
end
