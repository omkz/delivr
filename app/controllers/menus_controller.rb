class MenusController < ApplicationController
    def lists
      menus = Menu.order(:name).page params[:page]
      render json: menus
    end
end
