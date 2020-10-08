class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[show edit update]

  def index    
    @users = User.all - current_user.buddies - [current_user]
  end

  def show
    # testdata
    @interests = %w[technology painting linguistics literature]

    @native_language = current_user.native_language.name
    @target_language = current_user.target_language.name
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
end
