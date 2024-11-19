class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_article, only: [:update, :destroy]

  # CREATE
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # UPDATE
  def update
    if @article.user == current_user
      if @article.update(article_params)
        render json: @article, status: :ok
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are not authorized to edit this article.' }, status: :forbidden
    end
  end

  # DESTROY
  def destroy
    if @article.user == current_user
      @article.destroy
      render json: { message: 'Article deleted.' }, status: :ok
    else
      render json: { message: 'You are not authorized to delete this article.' }, status: :forbidden
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
