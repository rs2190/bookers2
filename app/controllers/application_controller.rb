# deviseのコントローラは直接修正できないため、全てのコントローラに対する処理を行える権限を持つ、ApplicationControllerに記述する必要があります。
class ApplicationController < ActionController::Base

  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に、configure_permitted_parametersメソッドが実行されます。
  before_action :configure_permitted_parameters, if: :devise_controller?

  # deviseのストロングパラメータ。<br>configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことでユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。(初期時は name を入力しても、データとして保存することはできない)
  def configure_permitted_parameters

     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
