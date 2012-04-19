module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		# la seguente non e' una semplice assegnazione di variabili. Invoca un
		# metodo esterno (il metodo current_user=(user)) per assegnare l'utente
		#  a una variabile d'istanza. 
		current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	# assegna, ma non restituisce niente (funzioni con segno = nel nome)
	def current_user=(user)
		@current_user = user
	end
	
	# restituisce @current_user. Se nil, lo riempie con user_from_remember_token
	def current_user
		@current_user ||= user_from_remember_token
	end

  def current_user?(user)
    user == current_user
  end

	def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

	def user_from_remember_token
		remember_token = cookies[:remember_token]
		User.find_by_remember_token(remember_token) unless remember_token.nil? 
	end

	def sign_out
		current_user = nil
		cookies.delete(:remember_token)
	end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  private
  	def clear_return_to
      session.delete(:return_to)
    end

end
