enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed, not_received }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage(this.text, this.messageType, this.messageStatus, this.isSender);
}

List demoChatMessage = [
  ChatMessage("hi", ChatMessageType.text, MessageStatus.viewed, false),
  ChatMessage("hello", ChatMessageType.video, MessageStatus.viewed, true),
  ChatMessage("bye", ChatMessageType.audio, MessageStatus.not_sent, false),
  ChatMessage("Barca Won", ChatMessageType.audio, MessageStatus.not_view, true),
  ChatMessage(
      "Barca Won", ChatMessageType.audio, MessageStatus.not_received, true),
  ChatMessage("ya mast app hae yeh", ChatMessageType.text,
      MessageStatus.not_sent, true),
];
