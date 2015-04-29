class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results

  def sum_correct
    
  end
end
