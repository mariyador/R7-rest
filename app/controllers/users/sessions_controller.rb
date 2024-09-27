class Users::SessionsController < Devise::SessionsController
    respond_to :json
    skip_forgery_protection only: [:create]
  
    def destroy
      @logged_in_user = current_user
      super # Call the original destroy action from Devise
    end
  
    private
  
    def respond_with(resource, _opts = {})
      if resource.present? && resource.id.present?
        # Set the CSRF token in the cookies and response header
        cookies["CSRF-TOKEN"] = { value: form_authenticity_token, secure: true, same_site: :None, partitioned: true }
        response.set_header('X-CSRF-Token', form_authenticity_token)
        render json: { message: 'You are logged in.' }, status: :created
      else
        render json: { message: 'Authentication failed.' }, status: :unauthorized
      end
    end
  
    def respond_to_on_destroy
      if @logged_in_user
        log_out_success
      else
        log_out_failure
      end
    end
  
    def log_out_success
      render json: { message: "You are logged out." }, status: :ok
    end
  
    def log_out_failure
      render json: { message: "Hmm, nothing happened." }, status: :unauthorized
    end
  end
  