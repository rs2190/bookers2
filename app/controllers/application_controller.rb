# deviseのコントローラは直接修正できないため、全てのコントローラに対する処理を行える権限を持つ、ApplicationControllerに記述する必要があります。
class ApplicationController < ActionController::Base

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

end
