class MenusController < ApplicationController
    def lists
      menus = Menu.page params[:page]
      options = {
        include: [:restaurant]
      }

      render json: MenuSerializer.new(menus, options)
    end
end
