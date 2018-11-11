class Admin::AccessRequestService < Admin::BaseService
  COMPANY_ATTRIBUTE = %i(company_name legal_representative phone_number tax_identification_number address email).freeze

  def accept(access_request)
    access_request.approve!

    user = create_user(access_request)

    company = create_company(user, access_request)

    account = create_account(company)

    AccessRequestMailer.accept(
      access_request, user, user.raw_invitation_token, locale
    ).deliver_later
  end

  private

  def create_user(request)
    User.invite!(
      email: request.email,
      name: request.legal_representative,
      skip_invitation: true
    )
  end

  def create_company(user, request)
    params = request.slice(COMPANY_ATTRIBUTE)
    params['name'] = params.delete('company_name')
    user.create_owner_company(params)
  end

  def create_account(company)
    nem_account = Admin::AccountService.generate_account
    account = company.build_account
    account.private_key = nem_account.private_key
    account.public_key = nem_account.public_key
    account.address = nem_account.address
    account.save
  end
end
