# See http://docs.adhearsion.com for more information on how to write components or
# look at the examples in newly-created projects.
require 'restclient'

methods_for :dialplan do
  
  def call_out(number)
    puts 'doing it!'
    #ahn_log.tropo_outbound.debug '*'*10
    # Fetch the document details
    #record = JSON.parse RestClient.get COMPONENTS.tropo_outbound['couch_db'] + row['id']
    #ahn_log.tropo_outbound.debug number
    
    # Construct the URI to call 
    uri = "#{COMPONENTS.tropo_outbound['base_uri']}?action=create&token=#{COMPONENTS.tropo_outbound['token']}"
    uri = uri + "&destination=#{number}&caller_id=#{COMPONENTS.tropo_outbound['caller_id']}"
    uri = uri + "&tropo_tag=#{5}"
    puts uri
    #ahn_log.tropo_outbound.debug uri

    # Now request Tropo AGItate to make the call
    #ahn_log.tropo_outbound.debug 
    puts RestClient.get uri 
  end

  def treat_call
    # Fetch the DB record based on the tropo_tag we passed on the call to the Session API
    headers = JSON.parse tropo_headers
    record = JSON.parse RestClient.get COMPONENTS.couch_dialer['couch_db'] + headers['tropo_tag']
    
    # Set our voices and recognizer to Italian
    execute 'voice', 'luca'
    execute 'recognizer', 'it-it'
    
    # Welcome the user
    play "Bonjourno. This is Fabrizio's Pasta Palace catering calling!"
    play 'Which pasta shape would you like for your party?'
    
    # Ask them the question
    result = execute 'ask', { :prompt   => 'Your choices are spaghetti, vermicelli, capellini, linguine, bucatini or bavette',
                              :choices  => 'spaghetti, vermicelli, capellini, linguine, bucatini, bavette',
                              :attempts => 3,
                              :timeout  => 10 }.to_json
    # Parse the result back from Tropo                        
    response = JSON.parse(result[11..-1])
    
    # Updated the database with the choice
    record['status'] = 'ordered'
    ahn_log.treat_call.debug RestClient.post COMPONENTS.couch_dialer['couch_db'],
                                             record.merge!({ :pasta_choice => response['interpretation'] }).to_json,
                                             :content_type => 'application/json'
    
    play "#{response['interpretation']} it is! See you at your party. Arrivederci!"
  end
end