class Document < ActiveRecord::Base
  has_many :signatures
  has_many :signers, through: :signatures

  HELLOSIGN_TEMPLATE_IDS = {
    'Author Agreement' => '1d69b0138603da64007d53173dc273597fd7f78e',
    'Book Manager Agreement' => '10179156b998905477e2a3bdb308aafc28498ec3'
  }

  def send_to_hellosign
    response = HelloSign.send_signature_request_with_template(hellosign_hash)
    update_attributes(hellosign_id: response.data['signature_request_id'])
  end

  # IMPORTANT: do not use the code below for testing purposes. It will send emails
  # to Ken and everyone on the CC_LIST above.
  def hellosign_hash
    # For testing, comment out the real code and use this hash instead. Remember
    # to also use test email addresses in the web form.
    # {
    #   test_mode:     true,
    #   template_id:   HELLOSIGN_TEMPLATE_IDS[name],
    #   subject:       name,
    #   message:       'Please sign this document using HelloSign. Thank you!',
    #   signers:       signer_info + [{
    #                    email_address: 'leslie.lai@booktrope.com',
    #                    name: 'booktrope tester',
    #                    role: 'Booktrope'
    #                  }],
    #   ccs:           [ { email_address: '', role: 'Intake Manager'},
    #                    { email_address: '', role: 'HR/Accounting' } ],
    #   custom_fields: details
    # }

    {
      template_id:   HELLOSIGN_TEMPLATE_IDS[name],
      subject:       name,
      message:       'Please sign this document using HelloSign. Thank you!',
      signers:       signer_info + booktrope_signer,
      ccs:           cc_list,
      custom_fields: details
    }
  end

  def signer_info
    signers.map do |signer|
      {
        email_address: signer.email,
        name: signer.name,
        role: signer.role
      }
    end
  end

  def booktrope_signer
    [
      {
        email_address: 'ken@booktrope.com',
        name: 'Kenneth Shear',
        role: 'Booktrope'
      }
    ]
  end

  def cc_list
    [
      {
        email_address: 'jesse@booktrope.com',
        role: 'Intake Manager'
      },
      {
        email_address: 'evie.hutton@booktrope.com',
        role: 'HR/Accounting'
      }
    ]
  end
end
