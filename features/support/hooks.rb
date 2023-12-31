After do |scenario|
  if scenario.failed?
    tags = scenario.source_tag_names.map(&:downcase).map{|x| x.gsub('@','')}
    unless tags.include?("non-gui") || tags.include?("nongui")
      # encoded_img = page.driver.browser.screenshot_as(:base64)
      # embed("data:image/png;base64,#{encoded_img}", 'image/png', "----- SCREENSHOT OF THE FAILURE -----")
      path = "html-report/#{scenario.__id__}.html"
      page.driver.browser.save_screenshot(path)
      attach(path, "image/png")
    end
  end
end
