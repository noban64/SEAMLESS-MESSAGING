class RequestController < ApplicationController
  before_action :authenticate_user!, :get_user_params, :find_request
  before_action :authenticate_user_has_access_to_page, only: [ :show ]
  before_action :same_user, only: [ :create ]
  # before_action :request_decision, only: [ :update ]

  def find_request
    puts ("find request function")
    @request_exists  = Request.exists?(requesting_user_id: @initiating_user, user_id: @requested_user, denied: false)
    @searched_request =  Request.where(requesting_user_id: @initiating_user, user_id: @requested_user) if !@request_exists.nil?
    @already_friends = Friend.exists?(friend_id: @initating_user, user_id: @requesting_user)
  end
  def get_user_params ## get this to work with all controllers that parameters
    puts ("get user params function")
    puts params[:profile_id]
    if params[:profile_id].nil?
      puts("There is no profile selected!")
      return "There is no profile selected!"
    end
    @initiating_user = current_user.id
    @requested_user = params[:profile_id]
    # flash[:profile_id] = params[:profile_id] if params[:profile_id]
  end
  def authenticate_user_has_access_to_page
    if @requested_user.to_i != @initiating_user.to_i then
      flash[:notice] = "You shouldnt have access to this page!"
      redirect_to friends_path
    end
  end
  def same_user
    if @initiating_user == @requested_user then
      puts @initiating_user
      puts flash[:profile_id]
      puts("You guys are the same user.")
      puts current_user.id
      puts params[:id].class

      flash[:notice] = "hey... something is strange.. you can only follow different users!"
      # redirect_to friends_path
    end
  end

  def request_decision
    puts "decision controller"
    puts params[:request_id]
    puts params[:decision]
    flash[:request_id] = params[:request_id]
    flash[:decision] = params[:decision]
    update()
  end

  def show
    puts "show controller"
    @requests = Request.where(user_id: current_user.id, denied: false)
  end

  def create
    puts "Create controller"
    # uuid -> requester_id -> user_id -> denied?:
    begin
      puts ("Request_exists!")
      puts @request_exists
      puts @request_exists == true
      puts @already_friends
      @request = Request.create(requesting_user_id: @initiating_user, user_id: @requested_user) unless @request_exists || @already_friends
      # @request.save
    rescue => error
      puts error
    end
    redirect_to profile_path(current_user)
  end

  def update # accept/decline
    puts "update controller"

    @request = Request.find(params[:request_id])
    decision = params[:decision]

    puts "Update controller variables"
    puts (decision)
    puts (@request)
    if @request.nil?
      puts ("Request does not exist")
      flash[:notice] = "Request does not exist"
      redirect_to profile_request_path(current_user)
    end

    @request.update(denied: true)
    if decision == "true" then
      puts ("Friend request was accepted!")
      create_friend() unless @already_friends
    end
      redirect_to profile_request_path(current_user.id) and return
  end

  def create_friend
    ## must create unqiue index on friendlist
    begin
    @friend = Friend.create(friend_id: @request.requesting_user_id, user_id: current_user.id)

      # @friend.save
      redirect_to friends_list_path
    rescue => error
      puts error
    end
  end
end
