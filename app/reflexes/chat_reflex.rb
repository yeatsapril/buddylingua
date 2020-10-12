# frozen_string_literal: true
class ChatReflex < ApplicationReflex
  def update
    buddy = element.dataset[:match].to_i
    session[:buddy] = User.find(buddy)
    @buddy = session[:buddy]
  end
end
