class Public::ArticlesController < ApplicationController
  
  def new
    @article = Article.new
    @user = current_user
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = "投稿に成功しました"
      redirect_to article_path(@article.id)
    else
      @articles = Article.all
      @user = current_user
      flash.now[:alert] = "投稿に失敗しました"
      render :new
      @article = Article.new
    end
  end

def index
  @q = Article.ransack(params[:q])
  @articles = @q.result(distinct: true).includes(:user).page(params[:page]).order("created_at desc")
  @user = current_user
end

  def show
    @articles = Article.find(params[:id])
    @user = @articles.user
    @post_comment = PostComment.new
  end

  def edit
    article = Article.find(params[:id])
    unless article.user.id == current_user.id
      redirect_to articles_path
    end
      @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "更新に成功しました"
      redirect_to article_path(@article.id)
    else
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
  end
  
  private

  def article_params
    params.require(:article).permit(:image, :title, :body)
  end
  
end