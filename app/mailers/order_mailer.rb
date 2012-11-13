class OrderMailer < ActionMailer::Base
  default from: "from@example.com"

  def complete(order)
    @order = order
    mail(to: "peterson.deb@comcast.net", subject: "Your order was successful!")
  end
end
