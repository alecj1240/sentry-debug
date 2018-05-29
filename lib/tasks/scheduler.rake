desc "This task is to check for new Sentry errors and submit to DB"
task :check_sentry => :environment do
  @users = User.all
  @users.each do |user|
    uri = URI.parse("https://app.getsentry.com/api/0/projects/christopher-bot/christopher-bot/issues/")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{user.sentry_token}"
    request["statsPeriod"] = "24h"
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    @sentryErrors = JSON.parse(response.body)

    @sentryErrors.each do |error|
      if Sentryerror.find_by(title: error["title"]).nil?
        newSentryError = user.sentryerrors.new(culprit: error["culprit"], title: error["title"], sentry_id: error["id"], value: error["metadata"]["value"], count: error["count"])
        newSentryError.save
      end
    end
  end
end
