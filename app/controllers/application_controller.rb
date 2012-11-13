class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_cart
  helper_method :current_user

  def current_cart
    if session[:card_id]
      @current_cart ||= Cart.find(session[:card_id])
    else
      @current_cart = Cart.create
      session[:card_id] = @current_cart.id
    end
  end

   private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end
