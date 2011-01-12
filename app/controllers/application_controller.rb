class ApplicationController < ActionController::Base
  helper_method :current_user_session, :current_user
  
  protect_from_forgery

  # Cualquier excepción no contemplada es capturada por esta función. Se utiliza
  # para mostrar un mensaje de error personalizado
  rescue_from Exception do |exception|
    begin
      @title = t :'errors.title'

      unless response.redirect_url
        render :template => 'shared/show_error', :locals => {:error => exception}
      end

    # En caso que la presentación misma de la excepción no salga como se espera
    rescue => ex
      STDERR << "#{ex.class}: #{ex.message}\n\n"
      ex.backtrace.each { |l| STDERR << "#{l}\n" }
    end
  end

  private

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash.notice = t(:'messages.must_be_logged_in')

      store_location
      redirect_to new_user_session_url

      false
    else
      expires_now
    end
  end

  def require_no_user
    if current_user
      flash.notice = t(:'messages.must_be_logged_out')

      store_location
      redirect_to prints_url

      false
    else
      true
    end
  end

  def require_admin_user
    unless current_user.try(:admin) == true
      flash.alert = t(:'messages.must_be_admin')

      store_location
      redirect_to(current_user ? prints_url : new_user_session_url)

      false
    else
      expires_now
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)

    session[:return_to] = nil
  end
end