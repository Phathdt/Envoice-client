admin = User.create(email: 'owner@envoice.com', password: '123456', name: 'Owner', role: 1)

Company.create(
  name: "MILO ",
  legal_representative: "Khoa Nguyen",
  phone_number: "01647778186",
  tax_identification_number: "91231283",
  address: "Quan 2 Ho Chi Minh",
  email: "khoa@niviki.com",
)
