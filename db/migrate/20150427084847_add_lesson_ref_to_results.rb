class AddLessonRefToResults < ActiveRecord::Migration
  def change
    add_reference :results, :lesson, index: true, foreign_key: true
  end
end
