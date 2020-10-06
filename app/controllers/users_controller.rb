class UsersController < ApplicationController

  def show
    @user = { name: "bob", email: "bob@email.com" }
  end

end

