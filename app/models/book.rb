class Book < ApplicationRecord

  # アノテーション
  # 1:N　=  userモデル：Bookモデル
   belongs_to :user

end
