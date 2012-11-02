class LineItem < ActiveRecord::Base
  attr_accessible :price, :product.id, :quantity

  belongs_to :product
  belongs_to :cart

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
