import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<bool> message = [
    false,
    true,
    true,
    false,
    false,
    true,
    true,
    true,
    false,
    false,
    true,
    true,
    false,
    false,
    true,
    true,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),

      // appBar: AppBar(
      //   title: Text("data"),
      // ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back)),
                const Text("General Chat Group"),
                const Icon(Icons.search),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
              Text(
                  "3 online",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      return message[index] == true
                          ? const SenderMessage()
                          : const ReceiverMessage();
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.14,
                  child: TextField(
                    decoration: InputDecoration(
                        fillColor: const Color.fromARGB(15, 205, 205, 205),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none)),
                  ),
                ),
                const Icon(Icons.send)
              ],
            )
          ],
        ),
      )),
    );
  }
}

class SenderMessage extends StatefulWidget {
  const SenderMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<SenderMessage> createState() => _SenderMessageState();
}

class _SenderMessageState extends State<SenderMessage> {
  // bool receiver = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          margin: const EdgeInsets.only(left: 40, bottom: 10),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(
            minHeight: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.55,
                child: const Text(
                  'how are you today skljgksjd;lfkjdklfjkldjfkfdflkdfldfdjfkjdfjkldfdlfkdlfklfkldfkldfkldkfldkfldkfldkfldkflkdflkdflkdlfkldfkflkldfkflkdflkdlfkldkfldkfldkfldkfldkflk',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReceiverMessage extends StatefulWidget {
  const ReceiverMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiverMessage> createState() => _ReceiverMessageState();
}

class _ReceiverMessageState extends State<ReceiverMessage> {
  // bool receiver = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(),
        const SizedBox(
          width: 5,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10)),
          ),
          margin: const EdgeInsets.only(right: 40, bottom: 10),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(
            minHeight: 40,
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.55,
                child: const Text(
                  'how are you todayskdsdkfdmskjkldjhlsjklfhjdhfjdhkldjfjkjfhjkdhfjkdkfhkdjfhjhdjfkjdfkjdfkjdkfkdjfldfjfhjhdjhkjffkjdfdjk',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
