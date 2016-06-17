require 'csv'

class FurnitureController < ApplicationController
    class Furniture
        attr_accessor :pid, :item, :description, :price, :condition, :dimension_w, :dimension_l, :dimension_h, :img_file, :quantity, :category

        def initialize(pid, item, description, price, condition, dimension_w, dimension_l, dimension_h, img_file, quantity, category)
            @pid = pid
            @item = item
            @description = description
            @price = price
            @condition = condition
            @dimension_w = dimension_w
            @dimension_l = dimension_l
            @dimension_h = dimension_h
            @img_file = img_file
            @quantity = quantity
            @category = category
        end
    end

    def index
        @furniture_list = fetch_furniture

    end

    def detail
    end


    def detail
        @furniture_list = fetch_furniture

        @furniture = @furniture_list.find { |f| f.pid == params[:pid] }
    end

    def fetch_furniture
        furniture_list = []

        CSV.foreach("#{Rails.root}/mf_inventory.csv", headers: true) do |row|
            the_hash        = row.to_hash
            pid             = the_hash['pid']
            item            = the_hash['item']
            description     = the_hash['description']
            price           = the_hash['price']
            condition       = the_hash['condition']
            dimension_h     = the_hash['dimension_h']
            dimension_w     = the_hash['dimension_w']
            dimension_l     = the_hash['dimension_l']
            img_file        = the_hash['img_file']
            quantity        = the_hash['quantity']
            category        = the_hash['category']
            furniture       = Furniture.new pid, item, description, price, condition, dimension_l, dimension_w, dimension_h, img_file, quantity, category
            furniture_list << furniture
        end

        furniture_list


    end

end
