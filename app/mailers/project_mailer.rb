class ProjectMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_member(invitation)
    @project = invitation.project
    @invitation_code = invitation.code
    mail to: invitation.person.email, subject: "You are invited to the #{@project.name} project on Scrumwich"
  end
end
