class Cart < ActiveRecord::Base
#attr_accessible :title, :body

  has_many :lineitems

  def total_cents
    #total = 0
    # lineitems.map(&:total).sum

      lineitems.sum(&:total)



    #lineitems.each do |li|
     # total += li.total
    #end
    #total
  end

end
