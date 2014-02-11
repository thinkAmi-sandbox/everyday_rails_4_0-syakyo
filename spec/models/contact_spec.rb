require 'spec_helper'

describe Contact do

  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address"

  it "is invalid with a duplicate email address" do
    Contact.create(
      firstname: 'Joe',
      lastname: 'Tester',
      email: 'tester@example.com')

    contact = Contact.new(
      firstname: 'Jane',
      lastname: 'Tester',
      email: 'tester@example.com')

    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = Contact.new(firstname: 'John',
                          lastname: 'Doe',
                          email: 'johndoe@example.com')

    expect(contact.name).to eq 'John Doe'
  end
end