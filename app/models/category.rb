class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  scope :sort, -> {order title: :asc}
end
