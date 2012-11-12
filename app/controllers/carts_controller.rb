class CartsController < ApplicationController
 #add item to cart

  def show
    if session[:cart_id]
      @cart = Cart.find(session[:card_id])
    else
      @cart = Cart.create
    end
  end

  def add
    if session[:cart_id] == nil
      @cart = Cart.create
      session[:cart_id] = @cart.id
    else
      @cart = Cart.find(session[:cart_id])
    end

    @product = Product.find(params[:id])

    if @line_item = @cart.line_items.find_by_product_id(@product)
      @line_item.quantity += 1
    else
      @line_item = @cart.line_items.new(product: @product, quantity: 1)
    end

    if @line_item.save
      flash[:notice] = "Added to cart"
    else
      flash[:error] = "Problem adding to cart"
    end
    redirect_to root_path
  end

  def remove
    @cart = Cart.find(session[:cart_id])
    @line_item = @cart.line_items.find(params[:id])
    if @line_item.destroy
      flash[:notice] = "#{@line_item.product.name} removed from cart"
    end
    redirect_to root_path
  end

  def checkout
    @cart = Cart.find(session[:cart_id])

    #automatically calls the file in the models directory when .create
    @order = Order.create!

    @cart.line_items.each do |line_item|
      @order.line_items << LineItem.new({product: line_item.product, quantity: line_item.quantity})
    end
    @order.save

    if @order.bill
      # assumes order can be successfully bill
      if @cart.destroy
        session[:cart_id] = nil
      end
      if OrderMailer.complete(@order).deliver
        flash[notice] = "an email has been sent ..."
      end

    end
    flash[:notice] = "Checkout was successful!"
    redirect_to root_path
  end

  def thankyou
  end
end
