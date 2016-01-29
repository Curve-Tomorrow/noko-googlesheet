require 'rails_helper'

describe User do
  include ActiveSupport::Testing::TimeHelpers

  context 'two users without entries' do
    let!(:user_list) { create_list(:user, 2) }

    context 'weekday' do
      it 'sends reminders to users without entries from today' do
        expect(Reminder).to receive(:send_to).twice.and_return(double 'Mailer', deliver: true)

        travel_to Time.new(2015, 07, 17, 0, 0, 0) do
          User.send_reminders
        end
      end
    end

    context 'weekend' do
      it 'does not send reminders' do
        expect(Reminder).not_to receive(:send_to)

        travel_to Time.new(2015, 07, 18, 0, 0, 0) do
          User.send_reminders
        end

        travel_to Time.new(2015, 07, 19, 0, 0, 0) do
          User.send_reminders
        end
      end
    end
  end

  context 'single user with an entry' do
    let(:user)   { create(:user, name: 'foo', email: 'bar@example.com') }
    let!(:entry) { create(:entry, user_id: user.id) }

    it 'should not send reminder to user with an entry' do
      expect(Reminder).to_not receive(:send_to).with(user)

      User.send_reminders
    end
  end

  describe '#minutes_of_current_week' do
    let(:user)   { create(:user) }
    let!(:entry) { create(:entry, minutes: 1337, user_id: user.id) }

    it 'sums up the correct amount of minutes for user in current week' do
      expect(user.minutes_of_current_week).to eq(1337)
    end

    context 'with entry from last week' do
      let!(:other_entry) { create(:entry, minutes: 10, user_id: user.id, date: 1.week.ago) }

      it 'does not sum up minutes from last week' do
        expect(user.minutes_of_current_week).to eq(1337)
      end
    end
  end
end
