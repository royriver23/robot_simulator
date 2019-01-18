module RobotSimulator
  RSpec.describe Commands::Left do
    include_examples 'direction examples' do
      let(:direction) { 'Left' }
    end
  end
end
