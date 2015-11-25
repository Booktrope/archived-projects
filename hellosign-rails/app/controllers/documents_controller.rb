require 'csv'

class DocumentsController < ApplicationController
  SIGNERS = ['author', 'book_manager']

  def home
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      find_or_create_signers(@document)
      begin
        @document.send_to_hellosign
      rescue HelloSign::Error::Error => e
        error_message = e.response_body['error']['error_msg']
        flash.alert = "Error sending document to HelloSign: #{error_message}"
      else
        flash.notice = 'Document successfully created!'
      end
    else
      flash.alert = "Oops, something went wrong. Please try again."
    end
    redirect_to root_path
  end

  def author_agreement
    @document = Document.new
  end

  def book_manager_agreement
    @document = Document.new
  end

  private

  def valid_params
    params.permit(:name, :author_name, :author_email, :work_title,
      :book_manager_name, :book_manager_email)
  end

  def document_params
    {
      name:    valid_params[:name],
      details: document_details
    }
  end

  # Signer params need to follow the naming convention of ending in either
  # '_name' or '_email'. E.g., 'author_name' or 'book_manager_email'.
  def signer_params
    valid_params.select { |k, v| k.end_with?('_name') || k.end_with?('_email') }
  end

  # Document details consist of any fields beyond the Document name and the
  # signer params plus any custom fields needed to fill out the HelloSign
  # template for that document.
  def document_details
    details = valid_params.reject { |k, v| signer_params.has_key?(k) || k == 'name' }

    case valid_params[:name]
    when 'Author Agreement'
      details.merge({ author_name: valid_params[:author_name] })
    when 'Book Manager Agreement'
      details.merge({ book_manager_name: valid_params[:book_manager_name] })
    else
      details
    end
  end

  def find_or_create_signers(document)
    signers = SIGNERS.map do |signer|
      if name(signer) && email(signer)
        Signer.where(
          name: name(signer),
          email: email(signer),
          role: signer
        ).first_or_create
      end
    end

    document.signers = signers.compact
  end

  def name(signer)
    signer_params[signer + '_name']
  end

  def email(signer)
    signer_params[signer + '_email']
  end
end
