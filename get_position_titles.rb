require 'nokogiri'

doc = Nokogiri::XML(File.read(ARGV[0]))

puts doc.xpath("/xmlns:Resume/xmlns:StructuredXMLResume/xmlns:EmploymentHistory/xmlns:EmployerOrg/xmlns:PositionHistory/xmlns:Title/text()")