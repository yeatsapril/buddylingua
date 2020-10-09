class MatchesController < ApplicationController
  before_action :set_user_match, only: %i[create]

  def create
    @match = Match.new
    @match.user_1 = current_user
    @match.user_2 = @user

    if @match.save
      flash[:notice] = "Added #{@user.name} as a buddy!"
    else
      flash[:alert] = "Failed to add #{@user.name} as a buddy."
    end
    redirect_to users_path
  end

  private

  def set_user_match
    @user = User.find(params[:user_id])
  end
end
