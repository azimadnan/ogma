class Library::BooksController < ApplicationController
  
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  # GET /books
  # GET /books.xml
  def index
    #@books = Book.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    @search = Book.search(params[:q])
    @books2 = @search.result
    @books = @books2.order(title: :asc).page(params[:page]||1)
    respond_to do |format|
      format.html # index.html.erb
      format.js #1Apr2013
      format.xml  { render :xml => @books }
    end
  end

  #start - import excel
  def import_excel
  end
  
  def import
      a=Book.import(params[:file]) 
      msg=Book.messages(a)     
      if a[:sye].count>0 || a[:ser].count>0 || a[:snu].count>0
	@invalid_year = a[:sye]
	@exist_records = a[:ser]
	@no_user = a[:snu]
        respond_to do |format|
          flash[:notice] = msg
          format.html { render action: 'import_excel' }
          flash.discard
        end
      else
	respond_to do |format|
	  format.html {redirect_to library_books_url, notice: msg}
	end
      end
  end
  
  def download_excel_format
    send_file ("#{::Rails.root.to_s}/public/excel_format/book_import.xls")
  end
  #end - import excel
  
  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    5.times { @book.accessions.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update(book_params)
        flash[:notice] = 'Book was successfully updated.'
        format.html { redirect_to(@book) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:tagno, :controlno,:isbn,:bookcode,:accessionno,:catsource,:classlcc,:classddc,:title,:author,:publisher,:description, :loantype,:mediatype,:status,:series,:location,:topic,:orderno,:purchaseprice,:purchasedate,:receiveddate,:receiver_id,:supplier_id,:issn, :edition, :photo_file_name, :photo_content_type,:photo_file_size,:photo_updated_at, :publish_date,:publish_location, :language, :links, :subject, :quantity, :roman, :size, :pages, :bibliography,:indice,:notes,:backuproman)
    end
  
end