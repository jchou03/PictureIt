import 'package:pictureit/Data/comment.dart';
import 'package:pictureit/Data/design.dart';
import 'package:pictureit/Data/project.dart';
import 'package:pictureit/Data/user.dart';
import 'package:pictureit/Data/idea.dart';
import 'package:flutter/src/widgets/image.dart';

class Test {
  static final List<User> users = [
    User("Mr. 437", "1234", "assets/images/Screenshot (437).png",
        "screenshot(437)@png.com"),
    User("Mr. 437", "1234", "assets/images/Screenshot (437).png",
        "screenshot(437)@png.com"),
    User("Mr. 437", "1234", "assets/images/Screenshot (437).png",
        "screenshot(437)@png.com"),
  ];

  static final String _body =
      """Aspernatur omnis consequatur dignissimos recusandae non. Praesentium nihil earum. Porro perspiciatis a velit doloremque consequatur impedit. Autem odio sed qui consequatur laboriosam sapiente omnis sit. Tenetur blanditiis iure molestias quidem odit numquam sunt aliquam.
 
Vitae libero perferendis voluptate et quasi aut impedit fuga. Maiores suscipit fugiat a est molestiae voluptas quasi earum recusandae. Ut omnis excepturi ut dolore ab.
 
Quia quo quisquam velit adipisci dolorem adipisci voluptatem. Eum ut quae et dolorem sapiente. Ut reprehenderit et ut voluptatum saepe et voluptatem. Sit eveniet quaerat.
Sit necessitatibus voluptatem est iste nihil nulla. Autem quasi sit et. Qui veniam fugit autem. Minima error deserunt fuga dolorum rerum provident velit.
 
Quod necessitatibus vel laboriosam ut id. Ab eaque eos voluptatem beatae tenetur repellendus adipisci repudiandae quisquam. Quis quam harum aspernatur nulla. Deleniti velit molestiae.
 
Repudiandae sint soluta ullam sunt eos id laborum. Veniam molestiae ipsa odit soluta in rerum amet. Deserunt rerum vero est eaque voluptas aspernatur ut voluptatem. Sint sed enim.""";

  static final List<Idea> ideas = [
    Idea("idea1"),
    Idea("idea2"),
    Idea("idea3"),
    Idea("idea4"),
    Idea("idea5")
  ];

  static final List<Idea> top3 = [Idea("idea1"), Idea("idea2"), Idea("idea3")];

  static final List<Idea> top = [Idea("idea1")];

  static final List<Design> top4 = [
    Design("idea1", "assets/images/Screenshot (437).png", users[0], _comments),
    Design("idea2", "assets/images/Screenshot (437).png", users[0], _comments),
    Design("idea3", "assets/images/Screenshot (437).png", users[0], _comments),
    Design("idea4", "assets/images/Screenshot (437).png", users[0], _comments),
    Design("idea5", "assets/images/Screenshot (437).png", users[0], _comments),
  ];

  static final List<Comment> _comments = <Comment>[
    Comment(
      users[0],
      "Et hic et sequi inventore. Molestiae laboriosam commodi exercitationem eum. ",
      DateTime(2019, 4, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2018, 5, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2017, 6, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2019, 4, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2018, 5, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2017, 6, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2019, 4, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2018, 5, 30),
    ),
    Comment(
      users[1],
      "Unde id provident ut sunt in consequuntur qui sed. ",
      DateTime(2017, 6, 30),
    ),
  ];

  List<Project> projects = [
    Project.specific(
      'I first learned about this problem as I noticed that the busses were empty every day',
      'I know that schoolchildren are affected becasue it pulls resources away from the routes that they need more busses for',
      'I interviewed 3 people, one student, one buisness worker, and a banana. After talking through all of them, they feel like they bus routes are poorly designed',
      'This problem affects most residents living in the suburbs outside of EPA because they have less access to useful bus routes.',
      'This problem is happening because there were government officials who coerced into designing this route to prevent less low income people from having easy access to the city center',
      'new route \nswitch large bus with smaller bus so new route \nsell bananas for money \nchange funding from unhelpful program to add new bus routes',
      ideas,
      top3,
      top,
      top4,
      _comments,
      DateTime(2019, 6, 29),
      5,
      users[0],
      "ScreenShot",
      "I can't take a sreenshot while sitting on the bench!",
    )
  ];
}
