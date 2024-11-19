class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    # Génére un token JWT après la connexion
    token = generate_jwt(current_user)

    render json: {
      message: 'You are logged in.',
      user: current_user,
      token: token  # Inclure le token dans la réponse
    }, status: :ok
  end

  def generate_jwt(user)
    payload = {
      sub: user.id,  # ID de l'utilisateur
      email: user.email,  # Email de l'utilisateur
      exp: 24.hours.from_now.to_i  # Expiration du token (par exemple 24 heures)
    }

    JWT.encode(payload, Rails.application.credentials.devise[:jwt_secret_key])
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end
