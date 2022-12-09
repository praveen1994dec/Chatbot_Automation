# hubot-slack-reactions

A hubot script like [/star me](#starme) except for slack reactions. Suggestions welcome read over the [contributing](/CONTRIBUTING.md) guidelines.

See [`src/slack-reactions.coffee`](src/slack-reactions.coffee) for full documentation.

#### Starme

Star me is what we would use at GitHub to pull random campfire stars from the api and post them in chat. We would use this feature to

- `star me -1year` Laugh about what we were saying a year ago today
- `star me pizza` Laugh about people talking about pizza
- `star me today` Catch up on the highlights from the chat room.

Slack uses [emoji reactions](https://slack.zendesk.com/hc/en-us/articles/206870317-Emoji-reactions) for all sorts of fun. This script does the same as the old star me, but uses reactions. There's even some useful shortcuts

- `star me` Get messages with reaction :star:
- `zap me` Get messages with reaction :zap:
- `react me :poop:` Get messages with reaction :poop:
- `react me @jonrohan :poop: -1year` Get the messages from jonrohan with reaction :poop: from one year ago today

## Configuration

You'll need to get your [Slack API Auth token](https://api.slack.com/web#authentication). Once you've gotten it for your org, set it as an environment variable.

```sh
export SLACK_ACCESS_TOKEN=xxxxxxxx
```

## Installation

In hubot project repo, run:

`npm install hubot-slack-reactions --save`

Then add **hubot-slack-reactions** to your `external-scripts.json`:

```json
[
  "hubot-slack-reactions"
]
```

## Sample Interaction

```
user1>> hubot react me -1year
hubot>> https://chat.slack.com/archives/general/p1d39f3463d000068
```

## Related

* [hubot-rubygems-search](https://github.com/jonrohan/hubot-rubygems-search)
* [hubot-itunes-search](https://github.com/jonrohan/hubot-itunes-search)

## License

MIT &copy; [Jon Rohan](http://jonrohan.codes)
