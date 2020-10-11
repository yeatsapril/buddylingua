# frozen_string_literal: true
class ChatReflex < ApplicationReflex
  def update
    match = element.dataset[:match].to_i
    @match = User.find(match)
  end
end
