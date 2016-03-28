class SubscribeUserToMailingListJob
  include SuckerPunch::Job

  def perform(user)
    Gibbon::Request.lists(Figaro.env.mailchimp_list_id).members.create(
      body: {
        email_address: user.email,
        status: "subscribed",
        merge_fields: {
          FNAME: "First Name",
          LNAME: "First Name"
        }
      }
    )
  rescue Gibbon::MailChimpError => error
    throw error unless error.title == "Member Exists"
  end
end
