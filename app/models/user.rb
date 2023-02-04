class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アノテーション
  # 1:N　=  userモデル：Bookモデル
  # dependent: :destroy は、1:N の「1」側にあたるデータが消えた時に、まとめて N 側のデータが消える
  has_many :books, dependent: :destroy

  # ActiveStorageでプロフィール画像を保存できるように設定しました。
  has_one_attached :profile_image

  # プロフィール画像のgetterメソッド。<br>画像サイズ指定可能(width(integer):横,height(integer):高さ)(px)
  def get_profile_image(width, height)

    # プロフィール画像が存在するか。
    unless profile_image.attached?

      # 存在しない場合

      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')

    end

    # 画像サイズの変更(px)
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
