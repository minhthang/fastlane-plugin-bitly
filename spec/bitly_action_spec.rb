describe Fastlane::Actions::BitlyAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The bitly plugin is working!")

      Fastlane::Actions::BitlyAction.run(nil)
    end
  end
end
