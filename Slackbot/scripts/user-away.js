module.exports = function(robot) {
    var users_away;
    users_away = {};
    robot.hear(/./i, function(msg) {
      if (users_away[msg.message.user.name] && msg.message.text !== 'brb') {
        msg.send("Ok I will wait for " + msg.message.user.name + "!");
        return delete users_away[msg.message.user.name];
      }
    });
    return robot.hear(/\b(brb|afk|bbl|bbiab|bbiaf)\b/i, function(msg) {
      return users_away[msg.message.user.name] = true;
    });
  };
  