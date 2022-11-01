class MainController < ApplicationController
  # before_action :must_be_logged_in 
  
  def login
  end

  def create 
    user = User.where(login: params[:login]).first
    if user && user.authenticate(params[:password])
      redirect_to main_user_item_path
      session[:logged_in] = true
      session[:userId] = user.id
    else
      redirect_to main_login_path, alert: 'wrong username or password'
    end
  end

  def user_item 
    if must_be_logged_in
      @user = User.where(id: session[:userId]).first
      @user_items = Item.where(user_id: session[:userId])
      @order = 1
    end
  end

  def shop
    if must_be_logged_in
      @user_items = Item.where(user_id: params[:id])    
      @order = 1
    end
  end

  def buy
    if must_be_logged_in
      item = Item.where(id: params[:id])
      if item[0]["stock"].to_i > 0  
        item_left = item[0]["stock"].to_i - 1
        Inventory.create(price: item[0]["price"], user_id: session[:userId], item_id: params[:id])
        item.update(stock: item_left)
        redirect_to :action => "shop"
      else 
        redirect_to :action => "shop", alert: "This item is out of order"
      end
    end
  end

  def inventories
    if must_be_logged_in
      @data = []
      @order = 1
      my_items = Inventory.where(user_id: session[:userId])
      my_items.each do |item| 
        item_info = Item.where(id: item.item_id)
        user = User.where(id: item_info[0]["user_id"])
        @data.push([user[0]["login"], item_info[0]["name"], my_items[0]["price"], my_items[0]["created_at"]])
      end
      pp @data
    end
  end

  def destroy
    reset_session
  end
end
