class BooksController < ApplicationController

  # 別ユーザーが更新などしないように制御を行う。
  before_action :is_matching_login_user_books, only: [:edit, :update, :destroy]

  def index

    user_info_new_book_current_user
    @books = book_all

  end

  def create

    # データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save

      notice("You have created book successfully.")

      path_jugde(controller_path, action_name)

      redirect_to book_path(@book.id)

    else

    @user = user_find_param(current_user.id)
    @books = book_all
    render :index

    end

  end

  def show

    user_info_new_book_current_user
    @book2 = book_find


  end

  def edit

    @book = book_find

  end

  def update

    @book = book_find
    book_id = @book.id

    if @book.update(book_params)

      redirect_book_path("You have updated book successfully.")
      redirect_to book_path(book_id)

    else

      render :edit

    end

  end

  def destroy

    # booksテーブルのidをキーにして、select。（1件取得）。
    book = book_find
    # 取得したデータを削除
    book.destroy
    # 詳細画面へリダイレクト
    redirect_to '/books'



  end

  private

  # ストロングパラメータ
  def book_params

    params.require(:book).permit(:title,:body)

  end

  # bookモデルのidでselect(1行)
  def book_find_book_id

    Book.find(@book.id)

  end

  # books/show画面遷移<br> word:noticeメッセージ
  def redirect_book_path(word)

    notice(word)
    user_info_new_book_current_user
    @book2 = book_find

  end

  # controller_path,action_nameで判定するインスタンスメソッド設定判定
  def path_jugde(controller_path,action_name)

    if (controller_path == 'users')

      if (action_name == 'index')
        user_info_new_book_current_user
        @book2 = book_find_book_id

      elsif (action_name == 'show')

        user_info_new_book_current_user
        @book2 = book_find_book_id

      end

    elsif (controller_path == 'books')

      if (action_name == 'index')

        user_info_new_book_current_user
        @book2 = book_find

      elsif (action_name == 'show')
        user_info_new_book_current_user
        @book2 = book_find

      end

    end

  end

end
