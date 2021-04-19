class Chat {
  final String name, image, time, lastMessage;
  final bool isActive;

  Chat({this.lastMessage, this.name, this.image, this.time, this.isActive});
}

List chatData = [
  Chat(
      name: 'Bhupesh',
      image: '',
      time: '3 min ago',
      isActive: false,
      lastMessage: 'Hi'),
  Chat(
      name: 'Anmol',
      image: '',
      time: '4 min ago',
      isActive: false,
      lastMessage: 'Hello'),
  Chat(
      name: 'Rachit',
      image: '',
      time: '1 min ago',
      isActive: true,
      lastMessage: 'Good Morning'),
  Chat(
      name: 'Elon',
      image: '',
      time: '9 min ago',
      isActive: false,
      lastMessage: 'Tesla'),
  Chat(
      name: 'Messi',
      image: '',
      time: '18 min ago',
      isActive: false,
      lastMessage: 'MS10'),
  Chat(
      name: 'Mark',
      image: '',
      time: '7 min ago',
      isActive: true,
      lastMessage: 'FB'),
  Chat(
      name: 'Steve',
      image: '',
      time: '10 min ago',
      isActive: false,
      lastMessage: 'Apple'),
  Chat(
      name: 'Ronaldo',
      image: '',
      time: '20 min ago',
      isActive: false,
      lastMessage: 'CR7'),
  Chat(
      name: 'Dhoni',
      image: '',
      time: '16 min ago',
      isActive: false,
      lastMessage: 'MSD'),
];
