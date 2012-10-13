# Description
#   Open's Everything.me HQ office door
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   OS_PUBNUB_SECRET_KEY
#	  OS_PUBNUB_PUBLISH_KEY
#	  OS_PUBNUB_SUBSCRIBE_KEY
#	  OS_PUBNUB_CHANNEL
#	  OS_KEY
#
# Commands:
#   hubot open door - Opens the office door
#   <trigger> - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   joeysim

module.exports = (robot) ->
  robot.respond /open (door|sesame)$/i, (msg) ->
    
    publish_key = process.env.OS_PUBNUB_PUBLISH_KEY
    subscribe_key = process.env.OS_PUBNUB_SUBSCRIBE_KEY
    secret_key = process.env.OS_PUBNUB_SECRET_KEY
    channel = process.env.OS_PUBNUB_CHANNEL
    key = process.env.OS_KEY

    reqUrl = 'http://pubsub.pubnub.com/publish/' + publish_key + '/' + subscribe_key + '/' + secret_key + '/' + channel + '/0/{"cmd": "open", "key": "' + key + '"}'
    console.log reqUrl

    # issue http request
    msg.http(reqUrl)
    .get() (err, res, body) ->
      response = JSON.parse(body)
      if response[0]=="1"
        console.log response
        msg.send "The deed was done"
      else
        msg.send "something went wrong, lockdown protocol initiated?"