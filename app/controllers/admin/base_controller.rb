class Admin::BaseController < ApplicationController
	before_action :authenticate_admin!
	helper_method :main_menu?, :sub_menu?
	attr_reader :main_menu, :sub_menu, :current_admin

	def current_admin
		@current_admin ||= session[:current_admin_id] && Admin.find_by(id: session[:current_admin_id])
	end

	protected
	def main_menu?(menu)
		main_menu == menu ? "active" : ""
	end

	def sub_menu?(menu)
		sub_menu == menu ? "active" : ""
	end


	def set_menu(main_menu, sub_menu=nil)
		@main_menu = main_menu
		@sub_menu = sub_menu
	end

	def authenticate_admin!
		unless current_admin.present?
			session.delete(:current_admin_id)
			session[:redirect_url_after_login] = request.url if request.get?
			redirect_to login_path, flash: {message: t("authenticate.fail")}
		end
	end
end
