class GetPayloadData {
  Payload payload;

  GetPayloadData({this.payload});

  factory GetPayloadData.fromJson(Map<String, dynamic> parsedJson) {
    return GetPayloadData(
      payload: Payload.fromJson(parsedJson['payload']),
    );
  }
}

class Payload {
  var order_uuid;
  var state;
  var comment;

  Payload({this.order_uuid, this.state, this.comment});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
        order_uuid: json['order_uuid'],
        state: json['state'],
        comment: json['comment'],
    );
  }
}
