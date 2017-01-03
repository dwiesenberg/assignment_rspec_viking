# RSPEC Viking -- Viking

require 'viking.rb'

describe Viking do
  let(:viking){Viking.new("Leif")}

  describe '#name' do #attr_reader method
    it 'returns name set by new Viking instance argument' do
      expect(viking.name).to eq("Leif")
    end
  end

  let(:viking_health){Viking.new("Leif", 150)}
  describe '#health' do #attr_reader method
    it 'returns health by new Viking instance argument' do
      expect(viking.health).to eq(150)
    end
  end

  # health cannot be overwritten after initialization problem -- note: impossible to test against being set anywhere in some methoid within the class Viking ... nust mean being reset outside the class through attr_writer. For this look for absence of method 'health=' ... that is, error raised if method is called.
  describe '#health=()' do # test for non-existance
    it 'raises error when called because it does not exist' do
      expect(viking.health=(50)).to raise_error
    end
  end

  # viking instance was not passed weapon argument
  describe '#weapon' do
    it 'is nil by default' do
      expect(viking.weapon).to eq(nil)
    end
  end

#  let(:wpn){Weapon.new} -- not needed here
  describe '#pick_up_weapon' do
    it 'sets weapon picked up' do
      allow(viking).to receive(:is_a?).and_return(false) # stub out 'is_a?' and therefore 'raise' at the same time
      expect(viking.pick_up_weapon("Spear")).to eq("Spear")
    end

#    let(:non_weapon){} # no weapon initialized -- not needed here
    it 'raises an exeption on picking up a non-weapon' do
      expect(viking.pick_up_weapon()).to raise_error 
        # does 'non-weapon' mean no argument or unspecified in children of class weapon? Assume the former here.
    end

    it 'replaces weapon on picking up a new one' do
      allow(viking).to receive(:is_a?).and_return(false) # stub out 'is_a?' and therefore 'raise' at the same time
      weapon_1 = viking.pick_up_weapon("Spear")
      weapon_2 = viking.pick_up_weapon("Shield")
      expect(weapon_1)).to_not eq(weapon_2)
    end
  end

  describe '#drop_weapon' do
    it 'leaves Viking with no weapon if he drops it' do
      expect(viking.drop_weapon).to eq(nil)
    end
  end

  describe '#receive_attack' do
    it 'reduces health by specified amount' do
      allow(viking).to receive(:puts)
      health_initial = viking.health
      allow(viking).to receive(:damage_dealt).and_return(10)
      viking.take_damage(damage_dealt)
      health_final = viking.health
      expect(health_initial - health_final).to eq(damage_dealt)
    end

    it 'calls #take_damage' do
      allow(viking).to receive(:puts)
      allow(viking).to receive(:damage_dealt).and_return(10)
      expect(viking).to receive(:take_damage(damage_dealt))
      viking.receive_attack
    end
  end


















































