class MenusController < ApplicationController
    def lists
      menus = Menu.page params[:page]
      render json: menus
    end
end
