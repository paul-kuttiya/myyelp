describe Review do
  it { should belong_to :user }
  it { should belong_to :business }
  it { should validate_presence_of :rating }
  it { should validate_presence_of :description }
  it { should ensure_length_of(:description) }
end