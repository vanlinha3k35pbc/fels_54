class AddWordRefToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :word, index: true, foreign_key: true
  end
end
