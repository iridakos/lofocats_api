require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { nil }

  subject { Ability.new(user) }

  context 'administrator' do
    let(:user) { FactoryGirl.build(:admin_user) }

    it 'should be able to manage the whole universe' do
      expect(subject.can?(:manage, :all)).to be true
    end
  end

  context 'normal user' do
    let(:user) { FactoryGirl.build(:user, :id => 1) }

    it 'should be able to sign out' do
      expect(subject.can?(:destroy, :session)).to be true
    end

    it 'should be able to read cat entries' do
      expect(subject.can?(:read, CatEntry)).to be true
    end

    it 'should be able to create cat entries' do
      expect(subject.can?(:create, CatEntry)).to be true
    end

    it 'should be able to update own cat entries' do
      expect(subject.can?(:update, FactoryGirl.build(:cat_entry, :user => user))).to be true
    end

    it 'should not be able to update other user cat entries' do
      other_user = FactoryGirl.build(:user, :id => 2)
      expect(subject.can?(:update, FactoryGirl.build(:cat_entry, :user => other_user))).to be false
    end

    it 'should be able to destroy own cat entries' do
      expect(subject.can?(:destroy, FactoryGirl.build(:cat_entry, :user => user))).to be true
    end

    it 'should not be able to destroy other user cat entries' do
      other_user = FactoryGirl.build(:user, :id => 2)
      expect(subject.can?(:destroy, FactoryGirl.build(:cat_entry, :user => other_user))).to be false
    end

    it 'should be able to show own profile' do
      expect(subject.can?(:read, subject)).to be false
    end

    it 'should not be able to show other users' do
      expect(subject.can?(:read, User.new(:id => 2))).to be false
    end

    it 'should not be able to show all users' do
      expect(subject.can?(:read_all, User)).to be false
    end

    it 'should not be able to create users' do
      expect(subject.can?(:create, User)).to be false
    end

    it 'should be able to update own profile' do
      expect(subject.can?(:update, subject)).to be false
    end

    it 'should not be able to update other users' do
      expect(subject.can?(:update, User.new(:id => 3))).to be false
    end

    it 'should not be able to destroy users' do
      expect(subject.can?(:destroy, User)).to be false
    end
  end

  context 'guest' do
    it 'should be able to create a session' do
      expect(subject.can?(:create, :session)).to be true
    end

    it 'should be able to read cat entries' do
      expect(subject.can?(:read, CatEntry)).to be true
    end

    it 'should not be able to create cat entries' do
      expect(subject.can?(:create, FactoryGirl.build(:cat_entry))).to be false
    end

    it 'should not be able to update cat entries' do
      expect(subject.can?(:update, FactoryGirl.build(:cat_entry))).to be false
    end

    it 'should not be able to delete cat entries' do
      expect(subject.can?(:delete, FactoryGirl.build(:cat_entry))).to be false
    end

    it 'should not be able to show all users' do
      expect(subject.can?(:read_all, User)).to be false
    end

    it 'should not be able to show users' do
      expect(subject.can?(:read, User)).to be false
    end

    it 'should not be able to create users' do
      expect(subject.can?(:create, User)).to be false
    end

    it 'should not be able to update users' do
      expect(subject.can?(:update, User)).to be false
    end

    it 'should not be able to destroy users' do
      expect(subject.can?(:destroy, User)).to be false
    end
  end
end
