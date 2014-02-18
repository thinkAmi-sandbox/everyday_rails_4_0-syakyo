require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(FactoryGirl.create(:contact)).to be_valid
  end


  it "is invalid without a firstname" do
    contact = FactoryGirl.build(:contact, firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end


  it "is invalid without a lastname" do
    contact = FactoryGirl.build(:contact, lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end


  it "is invalid without an email address" do
    contact = FactoryGirl.build(:contact, email: nil)
    expect(contact).to have(1).errors_on(:email)
  end


  it "is invalid with a duplicate email address" do
    FactoryGirl.create(:contact, email: "aaron@example.com")
    contact = FactoryGirl.build(:contact, email: "aaron@example.com")

    expect(contact).to have(1).errors_on(:email)
  end


  it "returns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact,
                                firstname: 'John',
                                lastname:  'Doe')

    expect(contact.name).to eq 'John Doe'
  end


  describe "fileter last name by letter" do
    before :each do
      @smith = FactoryGirl.create(:contact,
                              lastname:  'Smith',
                              email:     'jsmith@example.com')
      @jones = FactoryGirl.create(:contact,
                              lastname:  'Jones',
                              email:     'tjones@example.com')
      @johnson = FactoryGirl.create(
                              :contact,
                              lastname:  'Johnson',
                              email:     'jjohnson@example.com')
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end


    context "non-matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end


  it "has three phone numbers" do
    expect(FactoryGirl.create(:contact).phones.count).to eq 3
  end
end