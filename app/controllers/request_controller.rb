class RequestController < ApplicationController
  before_action :authenticate_user!, :get_user_params, :find_request

  def find_request
    @searched_request =  Request.where(requester_id: @initiating_user, user_id: @requested_user) if Request.exists?.where(requester_id: @initiating_user, user_id: @requested_user)
    @already_friends = Friend.where(friend_id: @initating_user, user_id: @requesting_user)
  end
  def get_user_params ## get this to work with all controllers that parameters
    if !params[:id]
      return "There is no profile selected!"
    end
    @initiating_user = current_user.id
    @requested_user = params[:id]
  end

  def show
    @requests = Request.where(user_id: current_user.id)
  end

  def new
    @request = Request.new(requester_id: @initiating_user, user_id: @requested_user) unless @searched_request.where(denied: false) || @already_friends
    # uuid -> requester_id -> user_id -> denied?:
    begin
      @request.save
    rescue => error
      puts error
    end
  end

  def accept
    @request = Request.find(@searched_request)
    if @request == nil

      flash[:notice] = "There was an error!"
      redirect_to friends_list_path
    end

    if @accept == false
      decline(@request)
    else
      create()
    end
  end

  def decline(request)
    request.delete
  end
end
