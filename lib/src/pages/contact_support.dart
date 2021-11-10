import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/chat_controller.dart';
import '../elements/ChatMessageListItemWidget.dart';
import '../elements/EmptyMessagesWidget.dart';
import '../models/chat.dart';
import '../models/conversation.dart';
import '../models/route_argument.dart';
import '../helpers/app_config.dart' as config;

class ChatWidget extends StatefulWidget {
  // final RouteArgument routeArgument;
  // final GlobalKey<ScaffoldState> parentScaffoldKey;

  ChatWidget({Key key}) : super(key: key);
  // ChatWidget({Key key, this.parentScaffoldKey, this.routeArgument}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends StateMVC<ChatWidget> {
  final _myListKey = GlobalKey<AnimatedListState>();
  final myController = TextEditingController();

  ChatController _con;

  _ChatWidgetState() : super(ChatController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForUser();
    // _con.getChats();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget chatListold() {
    if (_con.chats!= null)
    return StreamBuilder(
      stream: _con.chats,
      builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   // var _docs = _con.orderSnapshotByTime(snapshot);
        var _docs = snapshot.data.documents;
          return
            snapshot.hasData
              ?
          ListView.builder(
              key: _myListKey,
              reverse: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              // itemCount: snapshot.data.length,
              itemCount: _docs.length,
              shrinkWrap: false,
              primary: true,
              itemBuilder: (context, index) {
                // print(snapshot.data.documents[index].data());
                Chat _chat =
                Chat.fromJSON(_docs[index]);
                // _chat.user =
                //     _con.conversation.users.firstWhere((_user) => _user.id ==
                //         _chat.userId);
                return ChatMessageListItem(
                  chat: _chat,
                );
              })
              : EmptyMessagesWidget();
        // } else {
        //   return EmptyMessagesWidget();
        // }
      },
    );
    else return EmptyMessagesWidget();
  }

  Widget chatList() {
    // return StreamBuilder(
    //   stream: _con.chats,
    //   builder: (context, snapshot) {
        return _con.chatsList!=null && _con.chatsList.length>0
            ? ListView.builder(
            key: _myListKey,
            reverse: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            itemCount: _con.chatsList.length,
            shrinkWrap: false,
            primary: true,
            itemBuilder: (context, index) {
              Chat _chat = _con.chatsList.elementAt(index);
              // for(int i=0 ; i<_con.conversation.users.length ; i++) {
              //   print('----_chat.userId-'+_chat.userId);
              //   print('----_user-'+_con.conversation.users.elementAt(i).id);
              //   if(_con.conversation.users.elementAt(i).id == _chat.userId) {
              //     _chat.user = _con.conversation.users.elementAt(i);
              //   }
              // }
              // _chat.user = _con.conversation.users.firstWhere((_user) => _user.id == _chat.userId);
              return ChatMessageListItem(
                chat: _chat,
              );
            })
            : EmptyMessagesWidget();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 1,
                  left: 2,
                  right: 2,
                  bottom: 1),
              child: Stack(
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'Contact Support',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline4.merge(
                          TextStyle(
                              color: config.Colors().textColor(),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.keyboard_backspace_outlined,
                            size: 28,
                            color: config.Colors().textColor(),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 0.5,
              color: config.Colors().textColor(),
            ),
            Expanded(
              flex: 1,
              // child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(0),
                 child: Column(
                   mainAxisSize: MainAxisSize.max,
                   children: <Widget>[
                     Expanded(
                       child: chatList(),
                     ),
                     Container(
                       decoration: BoxDecoration(
                         color: Theme.of(context).primaryColor,
                         boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, -4), blurRadius: 10)],
                       ),
                       child: TextField(
                         controller: myController,
                         style: Theme.of(context).textTheme.bodyText1.merge(TextStyle()),
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.all(20),
                           hintText: 'Type To Start Chat',
                           hintStyle: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8))),
                           suffixIcon: IconButton(
                             padding: EdgeInsets.only(right: 30),
                             onPressed: () {
                               _con.addChatMessage(myController.text);
                               // _con.addMessage(_con.conversation, myController.text);
                               Timer(Duration(milliseconds: 100), () {
                                 myController.clear();
                               });
                             },
                             icon: Icon(
                               Icons.send,
                               color: Theme.of(context).accentColor,
                               size: 30,
                             ),
                           ),
                           border: UnderlineInputBorder(borderSide: BorderSide.none),
                           enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                           focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                         ),
                       ),
                     )
                   ],
                 ),
                ),
              // ),
            ),
          ],
        ),
      ),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   leading: new IconButton(
      //       icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
      //       onPressed: () {
      //
      //       }),
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     _con.conversation.name,
      //     overflow: TextOverflow.fade,
      //     maxLines: 1,
      //     style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
      //   ),
      //
      // ),
      // body: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: <Widget>[
      //     Expanded(
      //       child: chatList(),
      //     ),
      //     Container(
      //       decoration: BoxDecoration(
      //         color: Theme.of(context).primaryColor,
      //         boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, -4), blurRadius: 10)],
      //       ),
      //       child: TextField(
      //         controller: myController,
      //         decoration: InputDecoration(
      //           contentPadding: EdgeInsets.all(20),
      //           hintText: 'S.of(context).typeToStartChat',
      //           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
      //           suffixIcon: IconButton(
      //             padding: EdgeInsets.only(right: 30),
      //             onPressed: () {
      //               _con.addMessage(_con.conversation, myController.text);
      //               Timer(Duration(milliseconds: 100), () {
      //                 myController.clear();
      //               });
      //             },
      //             icon: Icon(
      //               Icons.send,
      //               color: Theme.of(context).accentColor,
      //               size: 30,
      //             ),
      //           ),
      //           border: UnderlineInputBorder(borderSide: BorderSide.none),
      //           enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      //           focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
