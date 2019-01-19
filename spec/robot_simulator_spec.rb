RSpec.describe RobotSimulator do
  it "has a version number" do
    expect(RobotSimulator::VERSION).not_to be nil
  end

  describe 'self.start?' do
    let(:cmd_params) { { width: 5, height: 5, outputters: [], report_on_every_command: false } }
    subject { described_class.start(cmd_params) }
    it 'calls RobotCli' do
      allow(RobotSimulator::RobotCli).to receive_message_chain(:new, :loop_user_input)
      subject
      expect(RobotSimulator::RobotCli).to have_received(:new).once
    end
  end
end
