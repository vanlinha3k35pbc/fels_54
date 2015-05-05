class RenameIsCorrectInAnswersToCorrect < ActiveRecord::Migration
  def change
    rename_column :answers, :isCorrect, :correct
  end
end
