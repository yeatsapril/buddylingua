# frozen_string_literal: true

class NotificationReflex < ApplicationReflex
  def update
    puts element.dataset
  end
end
