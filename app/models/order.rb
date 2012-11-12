class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, as: :itemable

  def bill
    true
  end

end
