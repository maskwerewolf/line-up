#encoding:utf-8
module System
  class RecodesController < SystemBaseController

    def index
      @recodes = RecodeLog.paginate(:page => params[:page], :per_page => 20)
    end

  end
end