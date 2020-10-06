class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @users = User.all
   end

  def show
    # testdata
    @user = User.find(params[:id])
    @interests = %w[England Denmark USA Canada Portugal Russia]



    @native_language = Language.find(current_user.native_language_id).name
    @target_language = Language.find(current_user.target_language_id).name

  end



end

