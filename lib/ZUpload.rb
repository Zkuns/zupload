require 'qiniu'
require 'QNConfig'

class ZUpload
  def initialize
    @matchExtension = { dir: "/*.#{QNConfig::ValidExtension}",
                        rdir: "/**/*.#{QNConfig::ValidExtension}",
                        file: "" }
  end

  def up args
    Qiniu.establish_connection! access_key: QNConfig::AccessKey, secret_key: QNConfig::SecretKey
    filePath = handleParams args
    Dir.glob(filePath).each do |file_name|
      ZUpload.new.upload file_name
    end
  end

  def upload fileName
    put_policy = Qiniu::Auth::PutPolicy.new(
      QNConfig::BucketKey,
      fileName,
      3600
    )

    uptoken = Qiniu::Auth.generate_uptoken(put_policy)

    _, result, _ = Qiniu::Storage.upload_with_token_2(
      uptoken, 
      fileName,
      fileName,
      nil,
      { bucket: QNConfig::BucketKey }
    )
    puts QNConfig::RemoteUrl + result['key']
  end

  private

  def handleParams args
    case args.count
    when 0
      return '.' + @matchExtension[:dir]
    when 1
      return removeLastSlash(args[0]) + @matchExtension[:dir]
    when 2
      argument = { '-f' => :file, '-r' => :rdir }
      return removeLastSlash(args[1]) + @matchExtension[argument[args[0]]]
    else
      exit(0)
    end
  end

  def removeLastSlash str
    str&.chomp('/') || ''
  end

end
