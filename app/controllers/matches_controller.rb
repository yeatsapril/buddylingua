class MatchesController < ApplicationController
  before_action :set_user_match, only: %i[create destroy]
  before_action :set_match, only: %i[destroy]

  def create
    @match = Match.new
    @match.user_1 = current_user
    @match.user_2 = @user

    if @match.save
      flash[:notice] = "Added #{@user.name} as a buddy!
                        Head to your profile and start chat chatting!"
    else
      flash[:alert] = "Failed to add #{@user.name} as a buddy."
    end
    redirect_to users_path
  end

  def destroy
    Match.destroy(@match.ids[0])
    flash[:alert] = "Match deleted"
    redirect_to request.referrer || root_url
  end

  private

  def set_user_match
    @user = User.find(params[:user_id])
  end

  def set_match
    @match = @user.find_match(current_user)
  end
end
