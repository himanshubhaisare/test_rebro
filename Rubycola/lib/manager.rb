##
# Restaurant class that accepts order and serves meal
# Author : Himanshu Bhaisare
##
require 'csv'
require 'item'
require 'restaurant'

class Manager
  attr_accessor :menu, :orig_order, :order, :restaurants
  
  def initialize(menu, order)
    @menu = menu
    @order = order
    @orig_order = order
  end
  
  # reads csv and makes restaurant objects
  def take_order
    new_menu = CSV.readlines(@menu)
    @restaurants = Array.new
    
    # Make restaurant object and store item in it
    new_menu.each do |arr| 
      #concatenate all items if combo
      if arr.length > 3
        arr[2] = arr[2..arr.length].to_s
        item = Item.new(arr[2], arr[1].to_f, TRUE)
      else
        item = Item.new(arr[2].strip!, arr[1].to_f, FALSE)
      end
      @restaurants << Restaurant.new(Integer(arr[0]), item)
    end
  end
  
  # logic to pick up cost effective lunch
  def serve_meal
    #go to each restaurant and check if all ordered items exist there
    @good_rest = Array.new
    combo = Array.new
    prices = {}
    @restaurants.each do |rest|
      item = rest.item
      #check if current item is combo and all ordered items is also a combo
      if item.item_name.include?(" ") # means it is combo, separate into individual items
        item_name = item.item_name.split(' ')
        item_name.each do |i|
          combo << i
        end
      end
      
      intersection = combo & @order
      
      if !intersection.empty?
        if(prices[rest.rest_num] == nil)
          prices[rest.rest_num] = 0
        end

        prices[rest.rest_num] += item.price
        if @order.length >= combo.length 
          @order = @order - combo
        else
          break
        end
      end
      
      #go through all ordered items
      @order.each do |ord|
        if (item.item_name.include?(ord))
          @good_rest << rest.rest_num
          
          if(prices[rest.rest_num] == nil)
            prices[rest.rest_num] = 0
          end
          
          prices[rest.rest_num] += item.price
        end
      end
      
    end
    
    # If no restaurant can serve your order, return nil
    if @good_rest.empty?
      return nil
    end
    
    # sort prices array and print the cheap restaurant
    prices = prices.sort {|a,b| a[1]<=>b[1]}
    #before printing confirm one last time that all the items ordered exist in this restaurant
    final = {}
    prices.each do |price|
      rest_menu = Array.new
      @restaurants.each do |rest|
        if rest.rest_num == price[0]
          item = rest.item.item_name
          if item.include?(" ") # means it is combo, separate into individual items
            item = item.split(' ')
            item.each do |i|
              rest_menu << i
            end
          else 
            rest_menu << item
          end
        end
      end
      
      intersection = rest_menu & @orig_order
      if(intersection.sort == @orig_order.sort)
        final[price[0]] = price[1]
      end
    end
    
    final = final.sort {|a,b| a[1]<=>b[1]}
    if !final.empty?
      return final[0][0].to_s + ", " + final[0][1].to_s
    else
      return nil
    end
  end
end