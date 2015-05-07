class AddUserRefToLessons < ActiveRecord::Migration
  def change
    add_reference :lessons, :user, index: true, foreign_key: true
  end
end
