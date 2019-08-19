require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper
    def get_page
      html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses')
      doc = Nokogiri::HTML(html)
      doc
    end
    def get_courses
      dude = get_page.css('.post')
      dude
    end
    def make_courses
        x = get_courses
          x.each do
            online_course = Course.new
            online_course.title = x.first.css('h2').text
            online_course.schedule = x.first.css('.date').text
            online_course.description = x.first.css('p').text
            online_course
          end
    end
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end
