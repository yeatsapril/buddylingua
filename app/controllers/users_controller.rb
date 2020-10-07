class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @users = User.all
   end

  def show
    # testdata
    @user = User.find(params[:id])
    @interests = %w[Technology painting linguistics literature]

    @native_language = current_user.native_language.name
    @target_language = current_user.target_language.name

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

  def user_params
    params.require(:user).permit(:description, :address, :age, :gender_id, :photo, :interest_ids)
  end

end

