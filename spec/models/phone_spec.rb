require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = FactoryGirl.create(:contact)
    home_phone = FactoryGirl.create(:home_phone,
                                    contact: contact,
                                    phone:   '785-555-1234')
    mobile_phone = FactoryGirl.build(:mobile_phone,
                                     contact: contact,
                                     phone: '785-555-1234')

    expect(mobile_phone).to have(1).errors_on(:phone)
  end


  it "allows two contacts to share a phone number" do
    FactoryGirl.create(:home_phone, phone: "785-555-1234")
    expect(FactoryGirl.build(:home_phone, phone: "785-555-1234")).to be_valid
  end
end