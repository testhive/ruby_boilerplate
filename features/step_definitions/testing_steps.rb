Given(/^I go to wikipedia$/) do
  visit ''
end

When(/^I search for term "([^"]*)"$/) do |term|
  search_box = find("[name=search]")
  search_box.set term
  search_box.send_keys :enter
end

Then(/^I should get multiple results with the term "([^"]*)"$/) do |term|
  expect(page).to have_selector(".mw-page-title-main", text: /#{term}/i)
end

Given(/^I test chatgpt conversation$/) do
  client = OpenAI::Client.new(access_token: ENV.fetch("openai_key"))
  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Give me 10 car makers which had raced in formula 1 but not anymore, respond in json format"}],
      temperature: 0.2,
    })
  p response
  p response.dig("choices", 0, "message", "content")

end

Given(/^I test cities api$/) do
  url = URI("https://countries-cities.p.rapidapi.com/location/country/GB?format=json")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = '5bf6bedc8fmsh06d176e557805f7p1305b5jsncef17c906f8b'
  request["X-RapidAPI-Host"] = 'countries-cities.p.rapidapi.com'

  response = http.request(request)
  puts response.read_body
end