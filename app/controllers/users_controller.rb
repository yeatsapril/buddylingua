class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[show edit update]
  # before_action :set_session_buddy, only: %i[show]

  def index
    handle_filters

    buddies = current_user.buddies
    @markers = buddies.map do |buddy|
      {
        lat: buddy.latitude,
        lng: buddy.longitude
      }
    end
  end

  def show
    # testdata
    if @user.buddies != []
      set_session_buddy
    end

    @interests = []
    @user.interests.each do |interest|
      @interests.push(interest.name)
    end

    @native_language = @user.native_language.name
    @target_language = @user.target_language.name
    @message = Message.new
  end

  def edit; end

  def update
    @user.interests = []

    params[:user][:interest_ids].delete_at(0)

    params[:user][:interest_ids].each do |interest_id|
      @user.interests << Interest.find(interest_id.to_i)
    end

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_session_buddy
    # if there is no current chat session
    if session[:buddy].nil?
      # set the session to the first buddy
      @buddy = @user.buddies.first
    else
      # else set the chat to the correct buddy
      @buddy = User.find(session[:buddy][:id].to_i)
      # if the previous session buddy is no longer a buddy
      if @user.find_match(@buddy).ids == []
        # set it to the first buddy
        @buddy = @user.buddies.first
      else
        # continue the session with the current buddy
        @buddy
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:description, :address, :age, :gender_id, :photo, :interest_ids)
  end

  def handle_filters
    session[:filter] = params[:filter]
    session[:filter_option] = params[:filter_option]
    @users = current_user.potential_buddies
    @genders = Gender.order(:name)
    @interests = Interest.order(:name)
    if session[:filter_option] && session[:filter] == "gender"
      @users = @users.where(gender_id: session[:filter_option])
    elsif session[:filter_option] && !session[:filter_option].empty? && session[:filter_option] == "interest"
      interest = Interest.find(session[:filter_option])
      @users = @users.joins(:interests).where('interests.id = :interest', interest: interest)
      # user_interests = UserInterest.where(interest_id: session[:filter_option])
      # @users = User.where(interest_id: session[:filter_option])
    end
    @users = @users.sort_by { |user| -current_user.match_percentage(user) }
  end
end
