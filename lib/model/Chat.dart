class Chat {
  final String name, image, lastSeenTime, lastMessage;
  final bool isActive;

  Chat(
      {this.lastMessage,
      this.name,
      this.image,
      this.lastSeenTime,
      this.isActive});
}

List chatData = [
  Chat(
      name: 'Bhupesh',
      image: '',
      lastSeenTime: '3 min ago',
      isActive: false,
      lastMessage: 'Hi'),
  Chat(
      name: 'Anmol',
      image: '',
      lastSeenTime: '4 min ago',
      isActive: false,
      lastMessage: 'Hello'),
  Chat(
      name: 'Rachit',
      image: '',
      lastSeenTime: '1 min ago',
      isActive: true,
      lastMessage: 'Good Morning'),
  Chat(
      name: 'Elon',
      image: '',
      lastSeenTime: '9 min ago',
      isActive: false,
      lastMessage: 'Tesla'),
  Chat(
      name: 'Messi',
      image: '',
      lastSeenTime: '18 min ago',
      isActive: false,
      lastMessage: 'MS10'),
  Chat(
      name: 'Mark',
      image: '',
      lastSeenTime: '7 min ago',
      isActive: true,
      lastMessage: 'FB'),
  Chat(
      name: 'Steve',
      image: '',
      lastSeenTime: '10 min ago',
      isActive: false,
      lastMessage: 'Apple'),
  Chat(
      name: 'Ronaldo',
      image: '',
      lastSeenTime: '20 min ago',
      isActive: false,
      lastMessage: 'CR7'),
  Chat(
      name: 'Dhoni',
      image: '',
      lastSeenTime: '16 min ago',
      isActive: false,
      lastMessage: 'MSD'),
];
