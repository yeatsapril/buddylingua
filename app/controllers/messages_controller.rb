class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create]

  def create
    @match = Match.find(params[:match_id])
    @message = Message.new({ content: params[:message_content] })
    @message.match = @match
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @match,
        render_to_string(partial: "message", locals: { message: @message })
      )

      # redirect_to user_path(current_user, anchor: "message-#{@message.id}", focus: "buddies")
    else
      render "user/show"
    end
  end
end
