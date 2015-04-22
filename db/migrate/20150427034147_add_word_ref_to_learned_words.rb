class AddWordRefToLearnedWords < ActiveRecord::Migration
  def change
    add_reference :learned_words, :word, index: true, foreign_key: true
  end
end
