class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    # モデル内でアソシエーションした場合、以下の記述で@book.のuser_idのカラムへユーザーの情報を入れられる
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Posting was successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      flash.now[:alert] = "Error, failed to post Did."
      render :index
      @book = Book.new
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def edit
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
      @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book information updated successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end