using TestProf::AnyFixture::DSL

RSpec.shared_context "supplier", supplier: true do
  using TestProf::AnyFixture::DSL
  # You should call AnyFixture outside of transaction to re-use the same
  # data between examples
  before(:all) do
    # The provided name ("supplier") should be unique.
    TestProf::AnyFixture.register(:supplier) do
      FactoryBot.create(:supplier)
    end
  end

  # Use .register here to track the usage stats (see below)
  # let(:supplier) { TestProf::AnyFixture.register(:supplier) }

  # Or hard-reload object if there is chance of in-place modification
  # let(:account) { Account.find(TestProf::AnyFixture.register(:account).id) }
end

# You can enhance the existing database cleaning. Posts will be deleted before fixtures reset
before_fixtures_reset do
  Supplier.delete_all
end
