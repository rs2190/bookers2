class Book < ApplicationRecord

  # アノテーション
  # 1:N　=  userモデル：Bookモデル
   belongs_to :user

   # title・・・空でないように設定
   validates :title, presence: true

  # body・・・空でない、かつ最大200文字まで
   validates :body,
     presence: true,
     length: { maximum: 200 }

end
