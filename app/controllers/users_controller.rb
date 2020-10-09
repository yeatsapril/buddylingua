class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[show edit update]

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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:description, :address, :age, :gender_id, :photo, :interest_ids)
  end

  def handle_filters
    session[:filter] = params[:filter]
    session[:filter_option] = params[:filter_option]
    @genders = Gender.order(:name)
    @interests = Interest.order(:name)
    if session[:filter_option] && session[:filter] == "gender"
      @users = User.where(gender_id: session[:filter_option]) - current_user.buddies - [current_user]

    elsif session[:filter_option] && session[:filter] == "interest"
      interest = Interest.find(session[:filter_option])
      @users = interest.users - current_user.buddies - [current_user]

      # user_interests = UserInterest.where(interest_id: session[:filter_option])
      # @users = User.where(interest_id: session[:filter_option])
    else
      @users = User.all - current_user.buddies - [current_user]

    end
  end

end
