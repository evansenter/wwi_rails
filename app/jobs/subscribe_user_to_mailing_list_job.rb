class SubscribeUserToMailingListJob
  include SuckerPunch::Job

  def perform(user)
    Gibbon::Request.lists(ENV["MAILCHIMP_LIST_ID"]).members.create(
      body: {
        email_address: user.email,
        status: "pending",
        merge_vars: {
          ANAME: "Full Name"
        }
      }
    )
  end
end
