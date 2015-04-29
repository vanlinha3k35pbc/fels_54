class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
