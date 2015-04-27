class RenameCorrectInanswerTocorrect < ActiveRecord::Migration
  def change
    rename_column :answers, :Correct, :correct
  end
end
