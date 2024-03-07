class MessageResponse {
  String? message;
  String? createdAt;
  String? sendBy;
  String? id;
  String? messageType;
  Reaction? reaction;
  ReplyMessageRes? replyMessage;

  MessageResponse({
    this.message,
    this.createdAt,
    this.sendBy,
    this.id,
    this.messageType,
    this.reaction,
    this.replyMessage,
  });

  MessageResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['createdAt'];
    sendBy = json['sendBy'];
    id = json['id'];
    messageType = json['messageType'];
    reaction = json['reaction'] != null ? Reaction.fromJson(json['reaction']) : null;
    replyMessage = json['replyMessage'] != null ? ReplyMessageRes.fromJson(json['replyMessage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['sendBy'] = this.sendBy;
    data['id'] = this.id;
    data['messageType'] = this.messageType;
    if (this.reaction != null) {
      data['reaction'] = this.reaction!.toJson();
    }
    if (this.replyMessage != null) {
      data['replyMessage'] = this.replyMessage!.toJson();
    }
    return data;
  }
}

class Reaction {
  String? reactions;
  String? reactedUserIds;

  Reaction({this.reactions, this.reactedUserIds});

  Reaction.fromJson(Map<String, dynamic> json) {
    reactions = json['reactions'];
    reactedUserIds = json['reactedUserIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reactions'] = reactions;
    data['reactedUserIds'] = reactedUserIds;
    return data;
  }
}

class ReplyMessageRes {
  String? messageType;
  String? message;
  String? messageId;
  String? replyBy;
  String? replyTo;
  String? voiceMessageDuration;

  ReplyMessageRes({
    this.messageType,
    this.message,
    this.messageId,
    this.replyBy,
    this.replyTo,
    this.voiceMessageDuration,
  });

  ReplyMessageRes.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    message = json['message'];
    messageId = json['messageId'];
    replyBy = json['replyBy'];
    replyTo = json['replyTo'];
    voiceMessageDuration = json['voiceMessageDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['messageType'] = this.messageType;
    data['message'] = this.message;
    data['messageId'] = this.messageId;
    data['replyBy'] = this.replyBy;
    data['replyTo'] = this.replyTo;
    data['voiceMessageDuration'] = this.voiceMessageDuration;
    return data;
  }
}
