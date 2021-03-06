class LineItem < ActiveRecord::Base
  attr_accessible :price, :product, :quantity

  belongs_to :itemable, polymorphic: true
  belongs_to :product

  before_create :save_price

  monetize :total_cents, :allow_nil => true

  def total_cents
    price.present? ? quantity * price : 0
  end

  private

  def save_price
    self.price = product.price
  end

end
