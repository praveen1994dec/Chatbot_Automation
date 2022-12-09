module.exports = function(robot) {
    robot.hear(/Hi/i, function(res) {
      return res.send("Hello!!!Thank you for choosing DevOps");
    });
    //You can set the bot to reply in specific channel
    robot.hear(/kubernetes/i, function(res) {
      var room;
      room = "devops";
      return robot.messageRoom(room, "Minikube is used for our handson.");
    });
    robot.respond(/!Jira (.*)/i, function(res) {
      var description;
      description = res.match[1];
      if (description === null) {
        return res.reply("Jira ticket cannot be created without desription");
      } else {
        return res.reply(`Jira ticket created with description ${description}`);
      }
    });
    //HIT THE REST ENDPOINT AND GET THE DATA
    return robot.respond(/data/i, function(res) {
      return res.http("https://api.covid19api.com/summary").header('Accept', 'application/json', {
        'Content-Type': 'application/json'
      }).get()(function(err, httpres, body) {
        var data;
        data = JSON.parse(body);
        //console.log data
        console.log("");
        if (err) {
          httpres.send("Error!");
        } else {
          return res.send(`${data.Countries[7].Country}` + "\thas the country code as\t" + `${data.Countries[7].CountryCode}`);
        }
      });
    });
  };
  