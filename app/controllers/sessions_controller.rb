class SessionsController < Devise::SessionsController
  after_filter :set_csrf_header, only: [:new, :create]

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    render json: {
      'csrf-param' => request_forgery_protection_token,
      'csrf-token' => form_authenticity_token
    }
  end
end