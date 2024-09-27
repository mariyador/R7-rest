class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    skip_forgery_protection only: [:create]
  
    private
  
    def respond_with(resource, _opts = {})
      if resource.persisted?
        register_success
      else
        register_failed(resource)
      end
    end
  
    def register_success
      # Set the CSRF token in the cookies and response header
      cookies["CSRF-TOKEN"] = { value: form_authenticity_token, secure: true, same_site: :None, partitioned: true }
      response.set_header('X-CSRF-Token', form_authenticity_token)
  
      # Render success response
      render json: { message: 'Signed up successfully.' }, status: :created
    end
  
    def register_failed(resource)
      # Render error response with validation messages
      render json: { message: resource.errors.full_messages }, status: :bad_request
    end
  end
  