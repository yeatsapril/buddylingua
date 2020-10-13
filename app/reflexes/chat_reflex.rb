# frozen_string_literal: true
class ChatReflex < ApplicationReflex
  def update
    # take the user id and set it to a session variable
    session[:buddy] = element.dataset[:match]
  end
end
