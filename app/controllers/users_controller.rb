class UsersController < ApplicationController

  def index

    # booksテーブルのidで昇順
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

    @user = user_find
    @book = book_new
    @books = book_all

  end

  def edit

     @user = user_find

  end

  def update
    @user = user_find
    @user.update(user_params)

    notice("You have updated user successfully.")
    redirect_to user_path(@user.id)

  end

  private

  # userのストロングパラメータ
  def user_params

    params.require(:user).permit(:name, :profile_image, :body)

  end

end
