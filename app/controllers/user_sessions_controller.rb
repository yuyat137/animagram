class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    # ログインするため、ユーザがemailとpasswordを入力したものを@userに代入
    @user = login(params[:email], params[:password]
    # もしユーザ情報とDBの情報が一致していたら、
    if @user
    # require_loginでユーザをログインページに誘導→ログインに成功したら、最初訪れていようとしていたページにredirectできる。
      redirect_back_or_to(root_path, success: 'ログインに成功しました')
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(root_path, success: 'ログアウトしました')
  end
end
