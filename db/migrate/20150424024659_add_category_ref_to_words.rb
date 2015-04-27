class AddCategoryRefToWords < ActiveRecord::Migration
  def change
    add_reference :words, :category, index: true, foreign_key: true
  end
end
