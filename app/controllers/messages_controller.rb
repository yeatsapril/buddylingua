class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create]

  def create
    puts params
    @match = Match.find(params[:match_id])
    @message = Message.new(message_params)
    @message.match = @match
    @message.user = current_user

    if @message.save
      ChatroomChannel.broadcast_to(
        @match,
        render_to_string(partial: "message", locals: { message: @message })
      )

      redirect_to user_path(current_user, anchor: "message-#{@message.id}")
    else
      render "user/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
