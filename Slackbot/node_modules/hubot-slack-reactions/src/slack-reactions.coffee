# Description
#   A hubot script like /star me except for slack reactions.
#
# Configuration:
#   SLACK_ACCESS_TOKEN
#
# Commands:
#   hubot react me -1year    - Show a random reaction from a year ago today
#   hubot react me @somebody - Show a message from someone with reactions
#   hubot react me :star:    - Show a message with :star: reactions
#
# Author:
#   Jon Rohan <yes@jonrohan.codes>

require 'datejs'

module.exports = (robot) ->
  robot.respond /(star|zap|reaction|react)( me)?(.*)/i, (msg) ->

    num = 1
    args = msg.match[3].split(/\s+/)
    terms = []

    for arg in args

      if arg.match(/^(today|yesterday|week|month|year)/)
        on_date = arg

      else if arg.match(/^(\-|\d)/)
        try
          if (parts = arg.split('+-')) and parts.length > 1
            date = Date.parse parts[0]
            dateRange = parts[1]

            m = dateRange.match(/^(\d+)(.+)$/)
            n = m[1]

            if m[2].match(/^mo/)
              dateRange = (n*4) + 'w'
            else if m[2].match(/^y/)
              dateRange = (n*52) + 'w'
            else if m[2].match(/^[smhdw]/)
              dateRange = (n) + m[2][0]
            else
              throw new Error 'invalid +- argument'
          else
            date = Date.parse(arg)
        catch e
          msg.send "Unknown date: #{arg}"
          return

      else if arg.match(/^x\d+$/)
        num = parseInt(arg.slice(1))

      else if arg.match(/^@/)
        user = arg.slice(1)

      else if arg.match(/^\:/)
        reaction = arg

      else
        terms.push(arg)

    q = ""
    if reaction
      q += "has:#{reaction}"
    else if msg.match[1] == "star"
      q += "has::star:"
    else if msg.match[1] == "zap"
      q += "has::zap:"
    else
      q += "has:reaction"

    q += " from:#{user}" if user
    q += " on:#{on_date}" if on_date
    q += " during:#{date.toString('yyyy-MM-dd')}" if date
    q += " #{terms.join(" ")}" if terms.length > 0

    msg
      .http("https://slack.com/api/search.messages")
      .query
        query: q,
        token: process.env.SLACK_ACCESS_TOKEN
      .get() (err, resp, body) ->
        if err?
          robot.emit 'error', err, msg
          return

        if resp.statusCode == 200
          result = JSON.parse(body)
          matches = result.messages.matches
          hits = []

          # Only show messages in public rooms
          matches = matches.filter (m) -> m.type == "message"

          if matches.length == 0
            msg.send "No reactions found =("
            return


          for i in [1..num]
            hit = matches.splice(Math.floor(Math.random() * matches.length), 1)[0]
            hits.push(hit) if hit

          for star in hits
            if robot.adapterName is 'slack'
              msgData =
                channel: msg.message.room
                text: star.permalink
                unfurl_links: true
              robot.emit 'slack.attachment', msgData
            else
              msg.send star.permalink
        else
          msg.send "couldn't retrieve reactions from chat: #{resp.statusCode} #{body}"
