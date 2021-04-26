enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed, not_received }

class ChatMessage {
  final String text; // Send Video/Audio length in seconds , eg "45"
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String sendTime;

  ChatMessage(this.text, this.messageType, this.messageStatus, this.isSender,
      this.sendTime);
}

List demoChatMessage = [
  ChatMessage("hi", ChatMessageType.text, MessageStatus.viewed, true, '12:01'),
  ChatMessage(
      "Hello my num : 9876543210\nEmail : abc@gmail.com\nWeb : www.google.com",
      ChatMessageType.text,
      MessageStatus.viewed,
      false,
      '12:20'),
  ChatMessage(
      "hello", ChatMessageType.video, MessageStatus.viewed, true, '1:02'),
  ChatMessage(
      "20", ChatMessageType.audio, MessageStatus.not_sent, false, '1:45'),
  ChatMessage(
      "400", ChatMessageType.audio, MessageStatus.not_view, true, '2:25'),
  ChatMessage(
      "5", ChatMessageType.audio, MessageStatus.not_received, true, '3:10'),
  ChatMessage("ya @mast app hae yeh", ChatMessageType.text,
      MessageStatus.not_sent, true, '3:12'),
];
