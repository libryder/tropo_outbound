require 'restclient'

methods_for :dialplan do
  
  def call_out(number)
    puts "Calling: #{number}"
    ahn_log.tropo_outbound.debug '*'*10
    
    # Construct the URI to call 
    uri = "#{COMPONENTS.tropo_outbound['base_uri']}?action=create&token=#{COMPONENTS.tropo_outbound['token']}"
    uri = uri + "&destination=#{number}&caller_id=#{COMPONENTS.tropo_outbound['caller_id']}"
    uri = uri + "&tropo_tag=#{5}"
    puts uri

    # Now request Tropo AGItate to make the call
    #ahn_log.tropo_outbound.debug 
    ahn_log.tropo_outbound.debug RestClient.get uri 
  end
  
end