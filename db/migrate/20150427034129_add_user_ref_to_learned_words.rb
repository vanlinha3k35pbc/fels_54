class AddUserRefToLearnedWords < ActiveRecord::Migration
  def change
    add_reference :learned_words, :user, index: true, foreign_key: true
  end
end
