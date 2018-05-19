class Admin::NoticesController < Admin::BaseController
  before_action :set_menu
  before_action :find_notice, only: [:show, :edit, :update, :destroy]
  def index
    @notices = Notice.all.order(id: :desc)
  end

  def show
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.admin_id = current_admin.id

    if @notice.save
      redirect_to notices_path, flash: { success: t(".success") }
    else
      flash.now[:fail] = t(".fail")
      render :new
    end
  end

  def edit
  end

  def update
    if @notice.update(notice_params)
      redirect_to notice_path(@notice), flash: { success: t(".success") }
    else
      flash.now[:fail] = t(".fail")
      render :new
    end
  end

  def destroy
    result = @notice.destroy
    if result
      redirect_to notices_path, flash: { success: t(".success") }
    else
      redirect_to notices_path, flash: { success: t(".fail") }
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:title, :content)
  end

  def find_notice
    @notice = Notice.find(params[:id])
  end

  def set_menu
    super("notices", params[:action])
  end
end
