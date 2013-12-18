class Project < ActiveRecord::Base
  belongs_to :owner, class_name: :Person
  has_many :entries
  has_and_belongs_to_many :people, -> { uniq }

  validates :name, presence: true, length: { maximum: 40 }
  validates :owner, presence: true

  def owner=(val)
    people << val
    super val
  end

  def last_10_days
    (0..9).map do |days_back|
      date = DateTime.now - days_back
      results = entries.for_day date
      results.empty? ? date : results
    end
  end

  def invite_people(emails)
    emails.each do |email|
      invite_person email
    end
  end

  def invite_person(email)
    person = Person.find_by email: email
    if person.nil?
      person = Person.create! name: email, email: email
    end
    unless self.people.include? person
      self.people << person
      invitation = create_invitation person
      ProjectMailer.invite_member invitation
      invitation.destroy
    end
  end

  def create_invitation(person)
    inv = Invitation.new project: self, person: person
    inv.create_code
    inv.save
    inv
  end
end
