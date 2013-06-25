require 'spec_helper'

describe Resty::Request do
  context "without headers" do
    let(:request) { Resty::Request.new("foo.com") }
    let(:options) { stub(method: "get", path: "/api/merchants", data: {foo: "bar"}) }

    before(:each) do
      RestClient.stubs(:send)
    end

    context "#send_request" do
      before(:each) do
        request.send_request(options)
      end

      it "sends request" do
        RestClient.should have_received(:send).with("get", "foo.com/api/merchants", 
                                                    { params: {foo: "bar"} })
      end
    end
  end

  context "with headers" do
    let(:request) { Resty::Request.new("foo.com", { header: "value"}) }
    let(:options) { stub(method: "get", path: "/api/merchants", data: {}) }

    before(:each) do
      RestClient.stubs(:send)
    end

    context "#send_request" do
      before(:each) do
        request.send_request(options)
      end

      it "sends request" do
        RestClient.should have_received(:send).with("get", "foo.com/api/merchants", {header: "value"})
      end
    end
  end
end
