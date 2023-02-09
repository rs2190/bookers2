class Book < ApplicationRecord

  # アノテーション
  # 1:N　=  userモデル：Bookモデル
   belongs_to :user

   validates :title, presence: true
   validates :body, presence: true


end
