class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[show edit update]
  before_action :set_session_buddy, only: %i[show]

  def index
    handle_filters
  end

  def show
    # testdata
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
    if @user.buddies
      if session[:buddy].nil?
        session[:buddy] = @user.buddies.first
      elsif @user.find_match(session[:buddy]).ids == []
        session[:buddy] = @user.buddies.first
      else
        session[:buddy]
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
