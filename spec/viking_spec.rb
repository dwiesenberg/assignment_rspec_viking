# RSPEC Viking -- Viking

require 'spec_helper'
require 'viking'

describe Viking do
  let(:viking){Viking.new("Leif")}

  before do
    allow($stdout).to receive(:puts)
  end

  describe '#initialize' do 
    it 'returns name set by new Viking instance argument' do
      expect(viking.name).to eq("Leif")
    end

  let(:viking_health){Viking.new("Leif", 150)}
    it 'returns health by new Viking instance argument' do
      expect(viking_health.health).to eq(150)
    end

    it 'sets weapon to nil by default' do
      expect(viking.weapon).to eq(nil)
    end
  end


  # health cannot be overwritten after initialization problem -- note: impossible to test against being set anywhere in some methoid within the class Viking ... nust mean being reset outside the class through attr_writer. For this look for absence of method 'health=' ... that is, error raised if method is called.
  describe '#health=()' do # test for non-existance
    it 'raises error when called because it does not exist' do
      expect{viking.health=(50)}.to raise_error(NoMethodError)
    end
  end


#  let(:wpn){Weapon.new} -- not needed here
  describe '#pick_up_weapon' do
    it 'sets weapon picked up' do
      bow = Bow.new
      allow(viking).to receive(:is_a?).and_return(true) # stub out 'is_a?' and therefore 'raise' at the same time
      expect(viking.pick_up_weapon(bow)).to eq(bow)
    end

#    let(:non_weapon){} # no weapon initialized -- not needed here
    it 'raises an exeption on picking up a non-weapon' do
      expect{viking.pick_up_weapon(Hash.new)}.to raise_error("Can't pick up that thing") 
    end

    it 'replaces weapon on picking up a new one' do
      allow(viking).to receive(:is_a?).and_return(true) # stub out 'is_a?' and therefore 'raise' at the same time
      bow = Bow.new
      axe = Axe.new
      weapon_1 = viking.pick_up_weapon(bow)
      weapon_2 = viking.pick_up_weapon(axe)
      expect(weapon_1).to_not eq(weapon_2)
    end
  end

  describe '#drop_weapon' do
    it 'leaves Viking with no weapon if he drops it' do
      borg = Viking.new("Borg", 100, 10, Bow.new)
      expect(borg.drop_weapon).to eq(nil)
    end
  end

  describe '#receive_attack' do
    it 'reduces health by specified amount' do
      viking.receive_attack(10)
      expect(viking.health).to eq(90)
    end

    it 'calls #take_damage' do
      allow(viking).to receive(:take_damage).and_return(90)
      expect(viking).to receive(:take_damage)
      viking.receive_attack(10) # I think this is cooked!
    end
  end

  describe '#attack' do
    let(:olef){Viking.new("Olef")}
    it 'causes health of attacked Viking to drop' do
      viking.attach(olef)
      expect(olef.health).to be<100
    end

    it calls '#take_damage of attacked Viking' do
      allow(olef).to receive(:take_damage).and_return(85)
      expect(olef).to receive(:take_damage)
      viking.attack(olef)
    end

    context 'when attacking with no weapons' do
      it 'runs #damage_with_fists' do
        viking.drop_weapon
        allow(viking).to receive(damage_with_fists).and_return(2.5)
        expect(viking).to receive(:damage_with_fists)
        viking.attack(olef)
      end

      it 'deals Fists multiplier times strength damage' do
        viking.drop_weapon
        fists = Fists.new
          # Fists multiplier returned by #use
        expect(olef).to receive(receive_attack).and_return(damage = fists.use * viking.strength)
        viking.attack(olef)
      end
    end

    context 'attacking with weapon' do
      axe = Axe.new
      it 'runs #damage_with_weapon' do
        viking.pick_up_weapon(axe)
        expect(viking).to receive(:damage_with_weapon).and_return(60)
        viking.attack(olef)
      end

      it 'deals weapons multiplier times strength damage' do
        viking.pick_up_weapon(axe)
        expect(olef).to receive(receive_attack).with(damage = axe.use * viking.strength)
        viking.attack(olef)
      end
    end

    context 'attacking with empty bow' do
      let(:empty_bow){Bow.new(0)}
      it 'attacks with fists instead' do
        viking.picks_up_weapon(empty_bow)
        allow(viking).to receive(:damage_with_fists).and_return(2.5)
        allow(viking).to receive(:damage_with_fists)
        viking.attack(olef)
      end
    end

    it 'raises an error when kiiling a Viking' do
      beowulf = Viking.new("Beowulf", 10)
      allow(viking).to receive(:damage_dealt).and_return(30)
      expect{viking.attack(beowulf)}.to raise_error("Beowulf has died...")
      viking.attack(beowulf)
    end
  end
end















































