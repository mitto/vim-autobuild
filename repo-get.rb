require 'open-uri'
require 'rexml/document'

BASEURL = 'http://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/source/SRPMS/'
REPO = BASEURL + 'repodata/repomd.xml'

base_parsed = REXML::Document.new(open(REPO).read)

puts BASEURL + base_parsed.elements['//repomd/data[@type="primary_db"]/location'].attribute('href').to_s
