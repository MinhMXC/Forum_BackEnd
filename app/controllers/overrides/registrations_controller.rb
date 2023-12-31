module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    protected def render_create_error
      render json: {
        status: 'error',
        data:   resource_data,
        message: resource_errors
      }, status: 422
    end
  end
end
