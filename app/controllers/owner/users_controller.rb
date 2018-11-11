class Owner::UsersController < Owner::ApplicationController

  def index
    @staffs = User.staff.order(:id).page params[:page]
  end

  def new
    @staff = User.new
  end

  def create
    user = User.new(user_params)
    user.password = Devise.friendly_token
    if user.valid?
      user = User.invite!(user_params)
      user.save

      flash[:success] = t('.success')
      redirect_to owner_users_path
    else
      render 'new'
    end
  end

  def toggle
    user = User.staff.find(params[:id])
    user.toggle!(:blocked)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
