class UsersController < ApplicationController

  def index

    user_info_new_book_current_user
    # usersテーブルのidで昇順
    @users = User.all.order(id: "ASC")

  end

  def show

    # 新規登録後
    if (controller_path == 'devise/registrations' && action_name == 'new')

      notice("Welcome! You have signed up successfully.")

    # ログイン後
    elsif (controller_path == 'devise/sessions' && action_name == 'create')

      notice("Signed in successfully.")

    end

    user_info_new_book_show
    @books = Book.where(user_id: params[:id]).order(id: "ASC")

  end

  def edit

     @user = user_find

  end

  def update

    @user = user_find

    if @user.update(user_params)

      notice("You have updated user successfully.")
      redirect_to user_path(@user.id)

    else

      render :edit

    end

  end

  private

  # userのストロングパラメータ
  def user_params

    params.require(:user).permit(:name, :profile_image, :body)

  end

end
