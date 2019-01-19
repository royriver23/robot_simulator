require 'stringio'

module RobotSimulator
  RSpec.describe RobotCli do
    let(:robot) { double('robot', placed: true) }
    let(:surface) { double('surface') }
    let(:cli_data) { { command_verb: 'PLACE', command_params: %w[1 2 north] } }
    let(:cli) { double('cli', valid?: true, cli_data: cli_data) }
    let(:params) { { params: cli_data[:command_params], robot: robot, surface: surface } }
    subject { described_class.new(robot: robot, surface: surface, report_on_every_command: false) }

    describe 'initialize' do
      it 'populates instance variables' do
        expect(subject.instance_variable_get("@robot")).to eq(robot)
        expect(subject.instance_variable_get("@surface")).to eq(surface)
        expect(subject.instance_variable_get("@report_on_every_command")).to be_falsy
      end
    end

    describe 'loop_user_input' do
      let(:command) { double('command', perform?: true, perform: true ) }

      before do
        $stdin = StringIO.new("PLACE\n")
        allow(CommandDataExtractor).to receive(:new).with(command: 'PLACE').and_return(cli)
      end

      after { $stdin = STDIN }

      context 'invalid command' do
        let(:cli) { double('cli', valid?: false) }

        it 'extracts data without running command' do
          allow(Factories::CommandFactory).to receive(:instance)
          subject.loop_user_input

          expect(CommandDataExtractor).to have_received(:new).with(command: 'PLACE').once
          expect(Factories::CommandFactory).to_not have_received(:instance)
        end
      end

      context 'valid command and reporting' do
        before do
          allow(Factories::CommandFactory).to receive(:instance).with(cli.cli_data[:command_verb], params)
            .and_return(command)
        end

        subject { described_class.new(robot: robot, surface: surface, report_on_every_command: true) }

        it 'calls report if report_on_every_command' do
          allow(CommandDataExtractor).to receive(:new).with(command: 'report').and_return(cli)
          subject.loop_user_input
          expect(CommandDataExtractor).to have_received(:new).with(command: 'report').once
        end
      end

      context 'valid command' do
        before do
          allow(Factories::CommandFactory).to receive(:instance).with(cli.cli_data[:command_verb], params)
            .and_return(command)
        end

        it 'call command factory' do
          subject.loop_user_input
          expect(Factories::CommandFactory).to have_received(:instance).with(cli.cli_data[:command_verb], params).once
        end

        it 'performs command' do
          double('command', perform?: true)
          subject.loop_user_input
          expect(command).to have_received(:perform).once
        end
      end
    end
  end
end
