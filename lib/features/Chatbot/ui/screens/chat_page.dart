import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungerwatch/features/Chatbot/bloc/chat_bloc.dart';
import 'package:hungerwatch/features/Chatbot/models/chat.dart';

class ChatbotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatbotPageState();
  }
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ChatBloc chatBloc = ChatBloc();
  final chatControler = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    chatControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: body(
        child: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              // ignore: type_literal_in_constant_pattern
              case ChatSuccessState:
                List<ChatMessageModel> messages =
                    (state as ChatSuccessState).messages;
                return Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Chatbot",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Expanded(

                        child: ListView.builder(

                          
                            physics: BouncingScrollPhysics(),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                 // width: double.infinity,
                                  // width: size.width * 0.5,
                                  margin: messages[index].role == "user"
                                      ? const EdgeInsets.only(
                                          left: 180,
                                          top: 10,
                                          right: 0,
                                          bottom: 10)
                                      : const EdgeInsets.only(
                                          left: 2,
                                          top: 10,
                                          right: 50,
                                          bottom: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: messages[index].role == "user"?Color.fromARGB(255, 126, 197, 128):const Color.fromARGB(255, 140, 165, 178), 
                                           ),
                                  
                                  padding: const EdgeInsets.all(16),
                                  child: 
                                   Column(
                                     children:[ Text(
                                        messages[index].parts.first.text,
                                        softWrap: true,
                                        
                                        textAlign: messages[index].role == "user"
                                            ? TextAlign.end
                                            : TextAlign.start,
                                        style:
                                            TextStyle(
                                              color: Colors.grey[800],
                                            fontSize: 15,
                                        ),
                                      ),
                  ]),
                                  );
                            })),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: chatControler,
                              decoration: InputDecoration(
                                  hintText: "Send a message...",
                                  hintStyle:
                                       TextStyle(color:Colors.grey[700]),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent),
                                  )),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send,color: Colors.green,),
                            onPressed: () {
                              if (chatControler.text.isNotEmpty) {
                                String inputMessage = chatControler.text;
                                chatControler.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(
                                    inputMessage: inputMessage));

                                print(inputMessage);
                                print(messages.length);
                              }

                              //chatControler.clear();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
  double _calculateWidth(String text) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width + 32; // Adjust for padding
}
}

class body extends StatelessWidget {
  final child;
  const body({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          /*  Positioned(
              top: 0,
              left: 0,
              child:Text("HungerWatch",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),*/
          // Image.asset("assets/images/main_top.png",
          //width: size.width * 0.3)),
          /*Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
              )),*/
          /* Center(
            child: Image.asset(
              "assets/images/vrikka_logo.png",
              height: size.height * 0.2,
            ),
          ),*/
          child,
          // SvgPicture.asset("assets/icons/login.svg",height: size.height*0.2,)
        ],
      ),
    );
  }
}
