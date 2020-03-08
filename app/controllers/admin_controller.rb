class AdminController < ApplicationController

  before_filter :ensure_user_is_admin, :except => []

  def index
    @users = User.all
  end

  def reassign_role
    user = User.find user_params[:id]

    if user
      if user.id == current_user.id
        flash[:alert] = 'You cannot change your own role'
        return redirect_to admin_path
      end

      user.role = user_params[:role]

      if user.save :validate => false
        flash[:notice] = 'Successfully updated user role'
        redirect_to :controller => 'admin', :action => 'index'
      else
        flash[:alert] = 'Failed to update user role.'
        redirect_to admin_path
      end
    else
      flash[:alert] = 'User not found.'
      redirect_to admin_path
    end
  end

  def reset_statistics
    Song.reset_views_count

    flash[:notice] = 'Successfully reset statistics'
    redirect_to admin_path
  end

  private
    def user_params
      params.require(:user).permit(
        :role,
        :id
      )
    end
end
