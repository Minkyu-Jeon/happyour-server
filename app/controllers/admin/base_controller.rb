class Admin::BaseController < ApplicationController

	helper_method :main_menu?, :sub_menu?

	protected
	attr_reader :main_menu, :sub_menu

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
end
