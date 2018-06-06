desc "This task is to check for new Sentry errors and submit to DB"
task :check_sentry => :environment do
  require 'json'
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

        uri = URI.parse("https://www.googleapis.com/customsearch/v1?q=#{error["title"]}&cx=001638859173749984711:glesaa6k8uo&key=AIzaSyBQBjc5W-ACdzZW3zK_eq48s4NbwGrEWLQ")
        request = Net::HTTP::Get.new(uri)
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end

        counter = 1
        @linksString = String.new
        @googleResults = JSON.parse(response.body)
        @googleResults["items"].each do |link|
          if counter == 1
            @linksString = link["link"].to_s + "splithere" + link["title"].to_s
          elsif counter > 1 && counter <= 5
            @linksString = @linksString + ",#{link['link'].to_s}" + "splithere" + "#{link['title'].to_s}"
          else
          end
          counter += 1
        end
        puts @linksString
        puts @linksString.class

        newSentryError = user.sentryerrors.new(culprit: error["culprit"], title: error["title"], sentry_id: error["id"], value: error["metadata"]["value"], count: error["count"], links: @linksString)
        newSentryError.save
      end
    end
  end
end
