enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed, not_received }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String sendTime;

  ChatMessage(this.text, this.messageType, this.messageStatus, this.isSender,
      this.sendTime);
}
