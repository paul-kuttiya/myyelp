describe User do
  it { should have_many :reviews }
  it { should have_secure_password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of :email }
end  