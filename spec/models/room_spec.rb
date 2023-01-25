require 'rails_helper'

RSpec.describe Room, type: :model do
  shared_examples_for 'scope for lounge chairs' do
    let(:room) { Room.create(name: 'living room') }

    context 'when there is a room with a blue lounge chair' do
      let!(:blue_chair) { LoungeChair.create(room_id: room.id, color: 'blue') }

      it 'is empty' do
        expect(scope).to be_empty
      end
    end

    context 'when there is a room with a red lounge chair' do
      let!(:red_chair) { LoungeChair.create(room_id: room.id, color: 'red') }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end

    context 'when there is a room but it has no lounge chair' do
      before { room }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end
  end

  shared_examples_for 'scope for lounge chairs combined with scope for swing chairs' do
    let(:room) { Room.create(name: 'living room') }

    context 'when there is no lounge chair' do
      before { room }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end

    context 'when there is a red lounge chair' do
      let!(:red_chair) { LoungeChair.create(room_id: room.id, color: 'red') }

      it 'is not empty' do
        scope.niceql
        expect(scope).not_to be_empty
      end
    end

    context 'when there is a blue lounge chair' do
      let!(:red_chair) { LoungeChair.create(room_id: room.id, color: 'blue') }

      it 'is empty' do
        expect(scope).to be_empty
      end
    end
  end

  shared_examples_for 'scope for swing chairs' do
    let(:room) { Room.create(name: 'living room') }

    context 'when there is a room with a red swing chair' do
      let!(:red_chair) { SwingChair.create(room_id: room.id, color: 'red') }

      it 'is empty' do
        expect(scope).to be_empty
      end
    end

    context 'when there is a room with a blue swing chair' do
      let!(:blue_chair) { SwingChair.create(room_id: room.id, color: 'blue') }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end

    context 'when there is a room but it has no swing chair' do
      before { room }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end
  end

  shared_examples_for 'scope for swing chairs combined with scope for lounge chairs' do
    let(:room) { Room.create(name: 'living room') }

    context 'when there is no red swing chair' do
      before { room }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end

    context 'when there is a blue swing chair' do
      let!(:blue_chair) { SwingChair.create(room_id: room.id, color: 'blue') }

      it 'is not empty' do
        expect(scope).not_to be_empty
      end
    end

    context 'when there is a red swing chair' do
      let!(:red_chair) { SwingChair.create(room_id: room.id, color: 'red') }

      it 'is not empty' do
        scope.niceql
        expect(scope).to be_empty
      end
    end
  end

  describe 'scopes' do
    describe '.with_no_blue_lounge_chairs_working' do
      it_behaves_like 'scope for lounge chairs' do
        let(:scope) { Room.with_no_blue_lounge_chairs_working }
      end

      context 'when combined with .with_no_red_swing_chairs_working' do
        it_behaves_like 'scope for lounge chairs combined with scope for swing chairs' do
          let(:scope) { Room.with_no_blue_lounge_chairs_working.with_no_red_swing_chairs_working }
        end
      end
    end

    describe '.with_no_blue_lounge_chairs_not_working' do
      it_behaves_like 'scope for lounge chairs' do
        let(:scope) { Room.with_no_blue_lounge_chairs_not_working }
      end

      context 'when combined with .with_no_red_swing_chairs_not_working' do
        it_behaves_like 'scope for lounge chairs combined with scope for swing chairs' do
          let(:scope) { Room.with_no_blue_lounge_chairs_not_working.with_no_red_swing_chairs_not_working }
        end
      end
    end

    describe '.with_no_red_swing_chairs_working' do
      it_behaves_like 'scope for swing chairs' do
        let(:scope) { Room.with_no_red_swing_chairs_working }
      end

      context 'when combined with .with_no_blue_lounge_chairs_working' do
        it_behaves_like 'scope for swing chairs combined with scope for lounge chairs' do
          let(:scope) { Room.with_no_blue_lounge_chairs_working.with_no_red_swing_chairs_working }
        end
      end
    end

    describe '.with_no_red_swing_chairs_not_working' do
      it_behaves_like 'scope for swing chairs' do
        let(:scope) { Room.with_no_red_swing_chairs_not_working }
      end

      context 'when combined with .with_no_blue_lounge_chairs_not_working' do
        it_behaves_like 'scope for swing chairs combined with scope for lounge chairs' do
          let(:scope) { Room.with_no_blue_lounge_chairs_not_working.with_no_red_swing_chairs_not_working }
        end
      end
    end
  end
end
