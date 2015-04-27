class CreateLearnedWords < ActiveRecord::Migration
  def change
    create_table :learned_words do |t|

      t.timestamps null: false
    end
  end
end
