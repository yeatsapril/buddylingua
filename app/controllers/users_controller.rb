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

  end

end

