Gem::Specification.new do |s|
  s.name         = 'zupload'
  s.version      = '0.0.1'
  s.date         = '2016-07-26'
  s.summary      = 'a util update image file to qiniu'
  s.authors      = ['Zkun']
  s.email        = 'zhukun615090@outlook.com'
  s.files        = Dir['lib/*.rb']
  s.license      = 'MIT'
  s.executables  = ['zupload']
  s.require_path = 'lib'

  s.add_dependency('qiniu', '>= 6.8.0')
end
