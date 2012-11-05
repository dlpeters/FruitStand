class CartsController < ApplicationController
  def index
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
      @line_item = @cart.Line_items.new(product: @product, quantity: 1)
    end

    if @line_item.save
      flash[:notice] = "Added to cart"
    else
      flash[:error] = "Problem adding to cart"
    end

    redirect root_path
  end

  def remove
  end

  def checkout
  end

  def thankyou
  end
end
