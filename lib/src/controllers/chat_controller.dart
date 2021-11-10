import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezfastnow/src/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/chat.dart';
import '../models/User.dart' as local_user;
import '../models/conversation.dart';
import '../repository/chat_repository.dart';
import '../repository/notification_repository.dart';
import 'package:async/async.dart' show StreamGroup;

class ChatController extends ControllerMVC {
  Conversation conversation;

  ChatRepository _chatRepository;
  Stream<QuerySnapshot> conversations;
  Stream<QuerySnapshot> chats;
  GlobalKey<ScaffoldState> scaffoldKey;

  List<Conversation> conversationsList;
  List<Chat> chatsList;

  Stream<QuerySnapshot> fromChats;
  Stream<QuerySnapshot> toChats;
  List<Chat> fromChatsList;
  List<Chat> toChatsList;



  CollectionReference _conversationCollectionReference;
  CollectionReference _usersCollectionReference;

  local_user.User currentUser;

  ChatController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _chatRepository = new ChatRepository();
//    _createConversation();
  }

  listenForUser() async {
    var u = await FirebaseAuth.instance.currentUser;
    if (u != null) {
      getUserData(u.email).then((snapshots) {
        getUserListFromStream(snapshots).then((value) => {
              value.listen((event) {
                List<local_user.User> list = event;
                currentUser = list.elementAt(0);
                print('---user email---'+currentUser.email);
                print('---user email---'+currentUser.id);
                getChats();
              }),
            });
      });
    }
  }

  Future<Stream<QuerySnapshot>> getUserData(String email) async {
    _usersCollectionReference = FirebaseFirestore.instance.collection("users");
    return _usersCollectionReference
        .where('email', isEqualTo: email)
        .snapshots();
  }

  Future<Stream<List<local_user.User>>> getUserListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map((qShot) => qShot.docs
        .map((doc) => local_user.User(
              id: doc.id,
              email: doc.get('email'),
              name: doc.get('name'),
              dob: doc.get('dob'),
              gender: doc.get('gender'),
              selectedReason: doc.get('selectedReason'),
              selectedType: doc.get('selectedType'),
              fastStart: doc.get('fastStart'),
              fastEnd: doc.get('fastEnd'),
              isSocial: doc.get('isSocial'),
            ))
        .toList());
  }

  signIn() {
    //_chatRepository.signUpWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
//    _chatRepository.signInWithToken(currentUser.value.apiToken);
  }

  listenForConversations() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getUserConversation(user.uid).then((snapshots) {
        conversations = snapshots;
        getListFromStream(snapshots).then((value) => {
              value.listen((event) {
                conversationsList = event;
                if (conversationsList != null && conversationsList.length > 0) {
                  conversation = conversationsList.elementAt(0);
                } else {
                  List<local_user.User> users = [];
                  local_user.User adminUser = new local_user.User(
                      id: "176",
                      name: "EzFastNow Team",
                      email: 'admin@ezfastnow.com',
                      deviceToken: 'ezfastnow');
                  users.add(adminUser);
                  conversation =
                      new Conversation(users, name: 'Contact Support');
                }
                if (conversation != null && conversation.id != null) {
                  listenForChats(conversation);
                }
                setState(() {});
              }),
            });
      });
    }
    // _chatRepository.getUserConversations(user.uid).then((snapshots) {
    //   setState(() {
    //     conversations = snapshots;
    //
    //   });
    // });
  }

  Future<Stream<QuerySnapshot>> getUserConversation(String userId) async {
    _conversationCollectionReference =
        FirebaseFirestore.instance.collection("conversations");
    return _conversationCollectionReference
        .where('visible_to_users', arrayContains: userId)
        .snapshots();
  }

  Future<Stream<List<Conversation>>> getListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map((qShot) =>
        qShot.docs.map((doc) => Conversation.fromJSON(doc.data())).toList());
  }

  listenForChats(Conversation _conversation) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _conversation.readByUsers.add(user.uid);
      _chatRepository.getChats(_conversation).then((snapshots) {
        // setState(() {
        chats = snapshots;
        getChatListFromStream(snapshots).then((value) => {
              value.listen((event) {
                chatsList = event;
                setState(() {});
              }),
            });

        // });
      });
    }
  }

  getChats() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // getUserChats(user.uid).then((snapshots) {
      //   chats = snapshots;
      //   getUserChatListFromStream(snapshots).then((value) => {
      //         value.listen((event) {
      //           chatsList = event;
      //           setState(() {});
      //         }),
      //       });
      // });

      chatsList = [];
      fromChatsList = [];
      toChatsList = [];
      getUserFromChats(user.uid).then((snapshots) {
        fromChats = snapshots;
        getUserChatListFromStream(snapshots).then((value) => {
              value.listen((event) {
                fromChatsList = event;

                getUserToChats(user.uid).then((snapshots) {
                  toChats = snapshots;
                  getUserChatListFromStream(snapshots).then((value) => {
                    value.listen((event) {
                      toChatsList = event;
                      print('---to--'+toChatsList.length.toString());

                      // chatsList = [];
                      // chatsList.addAll(fromChatsList);
                      // chatsList.addAll(toChatsList);
                      // chatsList.sort((a, b) {
                      //   var adate = DateTime.fromMillisecondsSinceEpoch(a.time); //before -> var adate = a.expiry;
                      //   var bdate = DateTime.fromMillisecondsSinceEpoch(b.time); //before -> var bdate = b.expiry;
                      //   return bdate.compareTo(adate); //to get the order other way just switch `adate & bdate`
                      // });
                      // print('---all--'+chatsList.length.toString());
                      //
                      // setState(() {});
                    }),
                  });
                }).whenComplete(() => {
                  setChatData()
                });
              }),
            });
      });
    }
  }

  void setChatData() {
    chatsList = [];
    chatsList.addAll(fromChatsList);
    chatsList.addAll(toChatsList);
    chatsList.sort((a, b) {
      var adate = DateTime.fromMillisecondsSinceEpoch(a.time); //before -> var adate = a.expiry;
      var bdate = DateTime.fromMillisecondsSinceEpoch(b.time); //before -> var bdate = b.expiry;
      return bdate.compareTo(adate); //to get the order other way just switch `adate & bdate`
    });
    setState(() {});
  }

  Future<Stream<List<Chat>>> getUserChatListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map(
        (qShot) => qShot.docs.map((doc) => Chat.fromJSON(doc.data())).toList());
  }

  CollectionReference _chatCollectionReference;

  Future<Stream<QuerySnapshot>> getUserChats(String userId) async {
    List<Stream<QuerySnapshot>> streams = [];
    _chatCollectionReference = FirebaseFirestore.instance.collection("chats");

    var fromQuery = _chatCollectionReference
        .where('fromUser', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots();

    var toQuery = _chatCollectionReference
        .where('toUser', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots();

    streams.add(fromQuery);
    streams.add(toQuery);

    Stream<QuerySnapshot> results = StreamGroup.merge(streams);

    return results;
    // await for (var res in results) {
    //   res.documents.forEach((docResults) {
    //     print(docResults.data);
    //   });
    // }
  }

  Future<Stream<QuerySnapshot>> getUserFromChats(String userId) async {
    _chatCollectionReference = FirebaseFirestore.instance.collection("chats");
    return _chatCollectionReference
        .where('fromUser', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots();
    // List<Stream<QuerySnapshot>> streams = [];
    // _chatCollectionReference = FirebaseFirestore.instance.collection("chats");
    // var firstQuery = _chatCollectionReference
    //     .where('fromUser', isEqualTo: userId)
    //     .orderBy('time', descending: true)
    //     .snapshots();
    //
    // var secondQuery = _chatCollectionReference
    //     .where('toUser', isEqualTo: userId)
    //     .orderBy('time', descending: true)
    //     .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserToChats(String userId) async {
    _chatCollectionReference = FirebaseFirestore.instance.collection("chats");
    return _chatCollectionReference
        .where('toUser', isEqualTo: userId)
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<Stream<List<Chat>>> getChatListFromStream(
      Stream<QuerySnapshot> stream) async {
    return stream.map(
        (qShot) => qShot.docs.map((doc) => Chat.fromJSON(doc.data())).toList());
  }

  createConversation(Conversation _conversation) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      local_user.User uu = local_user.User(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          deviceToken: 'token');
      _conversation.users.insert(0, uu);
      _conversation.lastMessageTime =
          DateTime.now().toUtc().millisecondsSinceEpoch;
      _conversation.readByUsers = [user.uid];
      setState(() {
        conversation = _conversation;
      });
      _chatRepository.createConversation(conversation).then((value) {
        print('---listenchat from create conversation');
        listenForChats(conversation);
      });
    }
  }

  addMessage(Conversation _conversation, String text) {
    // var user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   Chat _chat = new Chat(
    //       text, DateTime.now().toUtc().millisecondsSinceEpoch, user.uid);
    //   if (_conversation.id == null) {
    //     _conversation.id = UniqueKey().toString();
    //     createConversation(_conversation);
    //   }
    //   _conversation.lastMessage = text;
    //   _conversation.lastMessageTime = _chat.time;
    //   _conversation.readByUsers = [user.uid];
    //   _chatRepository.addMessage(_conversation, _chat).then((value) {
    //     _conversation.users.forEach((_user) {
    //       if (_user.id != user.uid) {
    //         // sendNotification(
    //         //     text,
    //         //     ' S.of(context).newMessageFrom + " " + currentUser.value.name',
    //         //     _user);
    //       }
    //     });
    //   });
    // }
  }

  addChatMessage(String text) {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Chat _chat = new Chat(text, DateTime.now().toUtc().millisecondsSinceEpoch,
          user.uid, user.uid, currentUser.name, '176', 'Contact Support');

      // Chat _chat2 = new Chat("yes please", DateTime.now().toUtc().millisecondsSinceEpoch,
      //     '176', '176', 'EzFast Team', user.uid, currentUser.name);
      createChat(_chat);
      // createChat(_chat2);
    }
  }

  Future createChat(Chat chat) async {
    _chatCollectionReference = FirebaseFirestore.instance.collection("chats");
    try {
      await _chatCollectionReference.add(chat.toJson());
      getChats();
    } catch (e) {
      return e.message;
    }
  }

  deleteMessage(Conversation _conversation) {
    _chatRepository.deleteMessage(_conversation).then((value) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("채팅이 삭제되었습니다.")));
    });
  }

  orderSnapshotByTime(AsyncSnapshot snapshot) {
    final docs = snapshot.data.documents;
    docs.sort((QueryDocumentSnapshot a, QueryDocumentSnapshot b) {
      var time1 = a.get('time');
      var time2 = b.get('time');
      return time2.compareTo(time1) as int;
    });
    return docs;
  }
}
