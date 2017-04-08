describe Task do
  describe 'validations' do
    it do
      is_expected.to validate_presence_of :name
      is_expected.to validate_presence_of :priority
    end
  end
end
