class User < ApplicationRecord
	has_many :articles, dependent: :destroy

	# Il faut ajouter les deux modules commençant par jwt
	devise :database_authenticatable, :registerable,
	:jwt_authenticatable,
	jwt_revocation_strategy: JwtDenylist
end
