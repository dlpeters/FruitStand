class Product < ActiveRecord::Base
  attr_accessible :name, :price

  has_many :line_items


  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
end
