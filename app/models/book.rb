class Book < ActiveRecord::Base
  belongs_to :staff  , :foreign_key => 'receiver_id'
  belongs_to :addbook, :foreign_key => 'supplier_id'
  has_many  :accessions, :dependent => :destroy
  accepts_nested_attributes_for :accessions, :reject_if => lambda { |a| a[:accession_no].blank? }, :allow_destroy =>true
  
   #-----------Attach Photo---------------
  has_attached_file :photo,
                    :url => "/assets/books/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/books/:id/:style/:basename.:extension"
  validates_attachment_size :photo, :less_than => 500.kilobytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']    
  
  def book_quantity
      Accession.where(book_id: id).count
  end
  
  # define scope media type
  def self.mediatype_search(query) 
    where(mediatype: query)
  end
  
  # define scope status
  def self.status_search(query)
    where(status: query)
  end
  
  #define scope accessionno
  def self.accessionno_search(query)
    a=where(accessionno: query)
    if a!=nil
      book_of_acc = a
    else
      book_of_acc = Accession.where(accession_no: query).first.book
    end
    book_of_acc
  end
    
  # whitelist the scope
  def self.ransackable_scopes(auth_object = nil)
    [:mediatype_search]
    [:status_search]
    [:accessionno_search]
  end
  
end

# == Schema Information
#
# Table name: books
#
#  accessionno        :string(255)
#  author             :string(255)
#  backuproman        :string(255)
#  bibliography       :string(255)
#  bookcode           :string(255)
#  catsource          :string(255)
#  classddc           :string(255)
#  classlcc           :string(255)
#  controlno          :string(255)
#  created_at         :datetime
#  description        :string(255)
#  edition            :string(255)
#  id                 :integer          not null, primary key
#  indice             :string(255)
#  isbn               :string(255)
#  issn               :string(255)
#  language           :string(255)
#  links              :text
#  loantype           :integer
#  location           :string(255)
#  mediatype          :integer
#  notes              :string(255)
#  orderno            :string(255)
#  pages              :string(255)
#  photo_content_type :string(255)
#  photo_file_name    :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  publish_date       :string(255)
#  publish_location   :string(255)
#  publisher          :string(255)
#  purchasedate       :date
#  purchaseprice      :decimal(, )
#  quantity           :integer
#  receiveddate       :date
#  receiver_id        :integer
#  roman              :string(255)
#  series             :string(255)
#  size               :string(255)
#  status             :integer
#  subject            :text
#  supplier_id        :integer
#  tagno              :string(255)
#  title              :string(255)
#  topic              :string(255)
#  updated_at         :datetime
#
