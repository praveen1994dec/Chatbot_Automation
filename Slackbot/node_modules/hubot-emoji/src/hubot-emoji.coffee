# Description:
#  Emoji search
#
# Dependencies:
#  None
#
# Commands:
#  hubot emoji QUERY

module.exports = (robot) ->

  robot.respond /emoji (\w+)$/i, (msg) ->
    query = msg.match[1]
    if query
      msg.http("https://raw.githubusercontent.com/muan/emoji/gh-pages/emojis.json")
        .get() (err, res, body) ->

          robot.logger.debug "got emoji index"

          json = JSON.parse body
          results = ""

          for key, value of json
            if query in value
              results += ":#{key}: "

          msg.reply results
