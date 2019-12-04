require 'spec_helper'

describe ScheduleMailer do
  describe 'email' do
    before :each do
      @admin = User.create(id: 1, name: 'John Doe', email: 'jdoe@berkeley.edu', auth: true, admin: true)
      @auth_user = User.create(id: 2, name: 'Jane Doe', email: 'jdoe2@berkeley.edu', auth: true, admin: false)
    end

    let(:mail) { ScheduleMailer.schedule_email(@auth_user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eql('Schedule filled out')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['jdoe@berkeley.edu'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['notifications@example.com'])
    end

    it 'has the correct text' do
      expect(mail.body.encoded).to include('Hello John Doe, the schedule for Jane Doe has been filled out.')
    end
  end
end
