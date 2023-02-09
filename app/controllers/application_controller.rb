# deviseのコントローラは直接修正できないため、全てのコントローラに対する処理を行える権限を持つ、ApplicationControllerに記述する必要があります。
class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:top]
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に、configure_permitted_parametersメソッドが実行されます。
  before_action :configure_permitted_parameters, if: :devise_controller?

  # after_sign_in_path_forは、Deviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッド。
  def after_sign_in_path_for(resource)

    # users#show
    user_path(current_user.id)

  end

  # after_sign_out_path_forは、after_sign_in_path_forと同じくDeviseが用意しているメソッドでサインアウト後にどこに遷移するかを設定するメソッド
  def after_sign_out_path_for(resource)

    notice("Signed out successfully.")
    # homes#top
    root_path

  end


  # deviseのストロングパラメータ。<br>configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことでユーザー登録(sign_up)の際に、メールアドレス(:email]))のデータ操作を許可しています。(初期時は email を入力しても、データとして保存することはできない)
  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])

  end

  # フラッシュメッセージを定義
  def notice(word)

    flash[:notice] = word

  end

  # userテーブルのidをキーにして、select。（1件取得）。
  def user_find

     User.find(params[:id])

  end

  # userテーブルのパラメーターをidをキーにして、select。（1件取得）。
  def user_find_param(id)

    User.find(id)

  end

  # bookテーブルのidをキーにして、select。（1件取得）。
  def book_find

    Book.find(params[:id])

  end

  # bookをnew。
  def book_new

    Book.new

  end

  # allメソッドで、booksテーブルに保存されてる全データを取得
  def book_all

    # booksテーブルのidで昇順
    Book.all.order(id: "ASC")

  end

  # user_info,new_bookをインスタンス変数を定義
  def user_info_new_book_show

    @user = user_find
    @book = book_new

  end

  # user_info,new_bookをインスタンス変数を定義(一覧画面)
  def user_info_new_book_current_user

    @user = user_find_param(current_user.id)
    @book = book_new


  end

  # 他のユーザーからのアクセスを制限
  def is_matching_login_user

    user_id = params[:id].to_i

    unless user_id == current_user.id

      redirect_to users_path

    end

  end

  # 他のユーザーからのアクセスを制限（books版）
  def is_matching_login_user_books

    book = book_find
    user_id = book.user_id.to_i

    # 投稿したユーザーと同じIDか確認する。
    unless user_id == current_user.id

      redirect_to books_path

    end

  end


end
