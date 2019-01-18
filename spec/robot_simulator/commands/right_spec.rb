module RobotSimulator
  RSpec.describe Commands::Right do
    include_examples 'direction examples' do
      let(:direction) { 'Right' }
    end
  end
end
