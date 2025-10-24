class SearchController < ApplicationController
  before_action :authenticate_user!, :search

  def show
    if @results.nil? then
      return nil
    end

    @pagy, @records = pagy(@results)

    @results
  end

  def search
    puts "search function"
    if parse_params.length <= 0
      return @results = User.none
    end
    if User.exists?(email: parse_params)
      return @results = User.where(email: parse_params)
    end

    similar_results = similar_named_results
    if User.where("email LIKE ?", "#{similar_results[0]}").exists?
      @results = User.where("email LIKE ?", similar_results[0])
    elsif User.where("email LIKE ?", "#{similar_results[1]}").exists?
      @results = User.where("email LIKE ?", similar_results[1])
    end
  end

  def similar_named_results
      form_params = parse_params
      first_half = "#{form_params[0...(form_params.length/2)]}%"
      second_half = "%#{form_params[(form_params.length/2)...form_params.length]}"
     [ first_half, second_half ]
  end


  private
    def parse_params
      params[:user_name] || " "
    end
end
