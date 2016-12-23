RSpec.describe OmniAuth::Strategies::Dnsimple do
  subject { described_class.new(app, options) }
  let(:app)     { ->(*) {} }
  let(:options) { {} }

  describe "client options" do
    context "production" do
      it "exposes site" do
        expect(subject.options.client_options.site).to eq("https://api.dnsimple.com")
      end

      it "exposes authorize_url" do
        expect(subject.options.client_options.authorize_url).to eq("https://dnsimple.com/oauth/authorize")
      end

      it "exposes token_url" do
        expect(subject.options.client_options.token_url).to eq("https://api.dnsimple.com/v2/oauth/access_token")
      end
    end

    context "sandbox" do
      let(:options) { { sandbox: true } }

      it "exposes site" do
        expect(subject.options.client_options.site).to eq("https://api.sandbox.dnsimple.com")
      end

      it "exposes authorize_url" do
        expect(subject.options.client_options.authorize_url).to eq("https://sandbox.dnsimple.com/oauth/authorize")
      end

      it "exposes token_url" do
        expect(subject.options.client_options.token_url).to eq("https://api.sandbox.dnsimple.com/v2/oauth/access_token")
      end
    end

    context "override defaults" do
      let(:options) do
        {
          client_options: {
            site: "https://api.dnsimple.test",
            authorize_url: "https://dnsimple.test/oauth/authorize",
            token_url: "https://api.dnsimple.test/v2/oauth/access_token"
          }
        }
      end

      it "exposes site" do
        expect(subject.options.client_options.site).to eq("https://api.dnsimple.test")
      end

      it "exposes authorize_url" do
        expect(subject.options.client_options.authorize_url).to eq("https://dnsimple.test/oauth/authorize")
      end

      it "exposes token_url" do
        expect(subject.options.client_options.token_url).to eq("https://api.dnsimple.test/v2/oauth/access_token")
      end
    end
  end
end
