// TO GET THE OUTPUT OF EVERY REACTION
var handleReaction;

handleReaction = function(res) {
  var desc, item, message, preposition, reaction, type, user;
  message = res.message;
  item = message.item;
  switch (item.type) {
    case 'message':
      desc = `the message from channel ${item.channel} at time ${item.ts}`;
      break;
    default:
      desc = `an item of type ${item.type} that I don't recognize`;
  }
  type = message.type;
  user = `${message.user.real_name} (@${message.user.name})`;
  reaction = message.reaction;
  preposition = type === 'added' ? 'to' : 'from';
  return res.reply(`${user} ${type} a *${reaction}* reaction ${preposition} ${desc}.`);
};

module.exports = function(robot) {
  robot.react(handleReaction);
  return robot.logger.info('Listening for reaction_added, reaction_removed events');
};
