require_relative "test_helper"

describe "Channel Initialize" do
  before do
    @new_channel = Slack::Channel.new(
      1,
      "Ada_C11",
      "api_discussion",
    )
  end

  it "will create an instance of Channel" do
    expect(@new_channel).must_be_instance_of Slack::Channel
  end # it
end # outer describe