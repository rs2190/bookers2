class BooksController < ApplicationController

  def index

    user_info_new_book_index
    # usersテーブルのidで昇順
    @books = Book.all.order(id: "ASC")

  end

  def create

    # データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_param)
    @book.user_id = current_user.id

    if @book.save

      notice("You have created book successfully.")
      @book = Book.find(@book.id)
      redirect_to book_path(@book.id)

    else
      @books = Book.all
      render '/books'

    end

  end

  def show
  end

  def edit

    @book = book_find

  end

  def update
  end

  def destory
  end

  private

  # ストロングパラメータ
  def book_param

    params.require(:book).permit(:title,:body)

  end

end
