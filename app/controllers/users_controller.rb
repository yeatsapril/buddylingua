class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @users = User.all
   end

  def show
    # testdata
    @user = User.find(params[:id])
    @travels = %w[England Denmark USA Canada Portugal Russia]
    @interests = %w[Technology painting linguistics literature]


    @native_language = Language.find(current_user.native_language_id).name
    @target_language = Language.find(current_user.target_language_id).name

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

  end

end

